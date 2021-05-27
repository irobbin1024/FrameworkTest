# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
source 'git@gitlab.quvideo.com:Pods/GitHubSpecs.git'
source 'https://cdn.cocoapods.org/'
source 'git@gitlab.quvideo.com:Pods/Specs.git'

target 'FrameworkTest' do

# 表示默认使用framework，修改值之后请清空缓存，1. pod cache clean --all 2. 删除Pods目录
ENV['global_use_source']='0'
# 表示AFNetworking没有经过framework改造，不对他做额外处理
ENV['AFNetworking_ignore_framework']='1'
# 表示XYToolKit只使用源代码拉取，会忽略全局配置global_use_source
ENV['XYToolKit_use_source']='1'

# 提示：命令行也可以指定是否使用framework
# 命令行1: use_source=1 pod update，表示全局使用源代码拉取
# 命令行2: use_source=0 pod update，表示全局使用framework拉取
# 命令行3: XYToolKit_use_source=1 pod update，表示XYToolKit使用源代码拉取
# 命令行3: XYToolKit_use_source=0 pod update，表示XYToolKit使用framework拉取

pod 'XYCategory'
pod 'XYToolKit'
pod 'AFNetworking'

end
