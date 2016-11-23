d::Spec.new do |spec|
  spec.name         = 'Super'
  spec.version      = '0.1'
  spec.license      = 'MIT'
  spec.homepage     = 'https://github.com/storm890612/Super'
  spec.authors      = { 'Superman' => 'storm890612@gmail.com' }
  spec.summary      = '用于ios工程基础项目结构与通用组件，实现基础组件封装与快速开发。解耦控制器与数据请求。简化代码，提高效率。'
  spec.source       = { :git => 'https://github.com/storm890612/Super.git', :tag => spec.version }
  spec.ios.deployment_target  = '8.0'
  spec.source_files = 'Super/*.{h,m}'
  spec.requires_arc = true
  spec.framework  = 'UIKit' , 'Foundation'
end

