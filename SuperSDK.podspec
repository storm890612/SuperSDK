Pod::Spec.new do |s|
  s.name         = 'SuperSDK'
  s.version      = '0.1'
  s.license      = 'MIT'
  s.homepage     = 'https://github.com/storm890612/SuperSDK'
  s.authors      = { 'Superman' => 'storm890612@gmail.com' }
  s.summary      = 'ios工程基础项目结构与通用组件'
  s.description = '用于ios工程基础项目结构与通用组件，实现基础组件封装与快速开发。解耦控制器与数据
请求。简化代码，提高效率。'
  s.source       = { :git => 'https://github.com/storm890612/Super.git', :tag => s.version }
  s.ios.deployment_target  = '8.0'
  s.source_files = 'SuperSDK/SuperSDK/**/*.{h,m}'
  s.requires_arc = true
  s.framework  = 'UIKit' , 'Foundation' , 'AVFoundation'
end

