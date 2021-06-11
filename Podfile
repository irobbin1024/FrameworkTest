# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
source 'git@gitlab.quvideo.com:Pods/GitHubSpecs.git'
source 'https://cdn.cocoapods.org/'
source 'git@gitlab.quvideo.com:Pods/Specs.git'

target 'FrameworkTest' do
  
# 不设置use_source，默认使用源码
# GitHub项目默认使用源码

# use_source = 1 表示使用源码，use_source = 0 表示使用framework
ENV['use_source'] = '0'
# PodName_use_source 可以单独设置某个Pod是否使用framework
ENV['XYCategory_use_source'] = '1'

pod 'XYCategory'
pod 'XYToolKit'
pod 'AFNetworking'
pod 'SDWebImage'
pod 'XYVivaAlertView'
pod 'KTVCocoaHTTPServer'

end
