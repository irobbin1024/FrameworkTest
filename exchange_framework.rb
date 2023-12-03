require 'net/http'
require 'json'

@github_source='https://cdn.cocoapods.org'
@xy_sourcecode_source='git@github.com:irobbin1024/Specs.git'
@xy_framework_source='git@github.com:irobbin1024/FrameworkSpecs.git'

@xy_use_source=@xy_sourcecode_source
@github_use_source=@github_source
@server_pod_list=[]
@server_error=false

# 这里可以拉取最新的版本信息
#begin
#    uri = URI('http://10.0.32.32:8900/localpod')
#    response = Net::HTTP.get_response(uri)
#    if response.code == "200"
#        @server_pod_list = JSON.parse(response.body)
#        puts("🎉🎉🎉🎉 拉取Framework打包列表成功，共#{@server_pod_list.length}个")
#    else
#        @server_error = true
#        puts("❌ 拉取Framework打包列表失败")
#    end
#rescue => exception
#    puts("❌❌❌#{$!}")
#end

if ENV['force_use_framework']=='1' || ENV['force_use_framework']=='0'
  ENV['use_framework']=ENV['force_use_framework']
end

if ENV['use_framework']=='1'
  @xy_use_source=@xy_framework_source
  @github_use_source=@xy_framework_source
else
  @xy_use_source=@xy_sourcecode_source
  @github_use_source=@github_source
end

def xypod(name = nil, *requirements)
  exchange_pod(name, @xy_sourcecode_source, @xy_use_source, *requirements)
end

def github_pod(name = nil, *requirements)
    exchange_pod(name, @github_source, @github_use_source, *requirements)
end



def exchange_pod(name = nil, source_spec = nil, global_spec = nil, *requirements)
  version=requirements[0]
  if version
      version = version.gsub(/\s+/,"")
  end
  
  # 当前pod是否有打包framework到服务器, 0表示未判决或者不需要判决 1表示有打包 2表示没有打包
  framework_on_server_stauts="0"
  
  # 是否是固定版本号
  version_is_fix = true
  if version.nil? or version.start_with?("~>") or version.start_with?(">=") or version.start_with?("<=") or version.start_with?("<") or version.start_with?(">") or @server_error == true
      version_is_fix = false
  end
  
  # 是否传递了source
  is_require_source = false
  # 是否传递了path
  is_require_path = false
  # 是否传递了path
  is_require_git = false
  # 是否传递了podspec
  is_require_podspec = false
  requirements.each{ |item|
      if item.class == Hash and item[:source]
          is_require_source = true
      end

      if item.class == Hash and item[:path]
          is_require_path = true
      end

      if item.class == Hash and item[:git]
          is_require_git = true
      end

      if item.class == Hash and item[:podspec]
          is_require_podspec = true
      end
  }
  
  if version_is_fix == true and is_require_source == false and is_require_path == false and is_require_git == false and is_require_podspec == false and @server_error == false
    jsonObj = @server_pod_list
    framework_on_server_stauts = "1" # TODO: 这里应该设置成 2，为了屏蔽 Race 的影响，改为一律有匹配的打包
    jsonObj.each{ |item|
      if item["name"]==name and item["version"]==version
        framework_on_server_stauts = "1"
      end
    }
  end

  # 单独指定了pod
  if  ENV["#{name}_use_framework"]=='1' ||
      ENV["force_#{name}_use_framework"]=='1'
      # 如果当前没有打包framework，使用源代码
      if framework_on_server_stauts=="2"
        puts("⚠️  #{name} #{version} 没有匹配的Framework，这可能是个问题")
        requirements.push(:source=>source_spec)
        puts("🌕 #{name} #{version} 使用源代码")
      else
        requirements.push(:source=>@xy_framework_source)
        puts("🌕 #{name} #{version} 使用Framework")
      end
  elsif ENV["#{name}_use_framework"]=='0' ||
        ENV["force_#{name}_use_framework"]=='0'
    requirements.push(:source=>source_spec)
    puts("🌕 #{name} #{version} 使用源代码")
  else
    if global_spec==@xy_framework_source
      if framework_on_server_stauts=="2"
        puts("⚠️  #{name} #{version} 没有匹配的Framework，这可能是个问题")
        puts("🌕 #{name} #{version} 使用源代码")
        requirements.push(:source=>source_spec)
      else
        puts("🌕 #{name} #{version} 使用Framework")
        requirements.push(:source=>global_spec)
      end
    else
      puts("🌕 #{name} #{version} 使用源代码")
      requirements.push(:source=>global_spec)
    end
  end
  
  pod name, *requirements
end
