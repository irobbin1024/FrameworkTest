# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
source 'git@gitlab.quvideo.com:Pods/GitHubSpecs.git'
source 'https://cdn.cocoapods.org/'
source 'git@gitlab.quvideo.com:Pods/Specs.git'

# ⚠️⚠️⚠️⚠️保证拉取了XYEnvironment，并设置了XYHOME环境变量

# 表示当前使用framework
ENV['use_framework']='1'
# 表示当前使用源码
#ENV['use_framework']='0'

# 引入控制脚本
eval(File.open("#{ENV['XYHOME']}/bin/exchange_framework.rb").read) if File.exist? "#{ENV['XYHOME']}/bin/exchange_framework.rb"

install! 'cocoapods',
:preserve_pod_file_structure => true#保留Pod目录结构

target 'FrameworkTest' do

# 小影的库使用xypod引入，1.0.0存在framework，1.0.1不存在framework，可以切换看看效果
xypod 'HelloWorld', '1.0.1'
# github的库使用github_pod引入
github_pod 'YYModel', '1.0.4'
# 没有framework的库正常使用pod引入
pod 'AFNetworking'

end
