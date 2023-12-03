# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
source 'https://cdn.cocoapods.org/'
source 'git@github.com:irobbin1024/Specs.git'

# 表示当前使用framework
ENV['use_framework']='1'
# 表示当前使用源码
#ENV['use_framework']='0'

# 单独控制某个 Pod 的 framework 使用
#ENV['HelloWorld_use_framework']='0'

# 引入控制脚本
eval(File.open("./exchange_framework.rb").read) if File.exist? "./exchange_framework.rb"

install! 'cocoapods',
:preserve_pod_file_structure => true#保留Pod目录结构

target 'FrameworkTest' do

# xy的库使用xypod引入
  xypod 'HelloWorld', '1.0.1'
# github的库使用github_pod引入
  github_pod 'YYModel', '1.0.4'
# 没有framework的库正常使用pod引入
  pod 'AFNetworking'

end
