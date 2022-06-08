Pod::Spec.new do |spec|

  spec.name         = "HLLocation"
  spec.version      = "1.0.0"
  spec.summary      = "iOS坐标转换和坐标导航工具类"
  spec.default_subspec = 'Navigation'

  # 描述
  spec.description  = <<-DESC
      iOS坐标转换和坐标导航工具类。使用简单
  DESC

  # 项目主页
  spec.homepage     = "https://github.com/huangchangweng/HLLocation"
 
  # 开源协议
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  
  # 作者
  spec.author       = { "黄常翁" => "599139419@qq.com" }
  
  # 支持平台
  spec.platform     = :ios, "9.0"

  # git仓库，tag
  spec.source       = { :git => "https://github.com/huangchangweng/HLLocation.git", :tag => spec.version.to_s }

  # 坐标转换
  spec.subspec 'Converter' do |converter|
        converter.source_files = 'HLLocation/HLLocation/Converter/**/*'
        converter.public_header_files = 'HLLocation/HLLocation/Converter/**/*.h'
        converter.frameworks = 'UIKit', 'CoreLocation'
  end
  
  # 坐标导航
  spec.subspec 'Navigation' do |navigation|
        navigation.source_files = 'HLLocation/HLLocation/Navigation/**/*.{h,m}'
        navigation.public_header_files = 'HLLocation/HLLocation/Navigation/**/*.h'
        navigation.dependency 'HLLocation/Converter'
    end

end
