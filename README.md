# FrameworkTest
framework 使用端自由切换源码的演示工程

## 此工程的目的
是为了演示 Framework 相关的源码切换功能
这个工程展示了如何进行全局切换和单独控制某个 Pod 的切换
你可以在 Podfile 文件中看到相关代码

## 如何使用
### 第一步
你需要 clone 脚本工程 https://github.com/irobbin1024/FrameworkBin，放置在合适的位置

### 第二步
引入脚本到 podfile 中
```ruby
eval(File.open("#{ENV['XYHOME']}/bin/exchange_framework.rb").read) if File.exist? "#{ENV['XYHOME']}/bin/exchange_framework.rb"
```
请将exchange_framework.rb脚本替换为合适的路径

### 第四步
试用环境变量来控制 Framework 和源码的切换
全局使用源码
```ruby
ENV['use_framework']='0'
```

全局使用 framework
```ruby
ENV['use_framework']='1'
```

控制某个 Pod 使用源码，例如控制HelloWorld
```ruby
ENV['HelloWorld_use_framework']='0'
```

在引入新库的时候，使用特殊的语法
1. 如果这个库没有经过 Framework 改造，那么还是使用原来的 Pod
2. 如果改造过，且是 github 的三方库，那么使用 github_pod
3. 如果改造过，且是公司内部的库，那么使用 xypod

## 如何打包
本工程只演示使用
