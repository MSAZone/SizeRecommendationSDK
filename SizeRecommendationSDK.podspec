Pod::Spec.new do |s|
  s.name             = 'SizeRecommendationSDK'
  s.version          = '0.1.0'
  s.summary          = 'A lightweight SDK for size recommendations.'
  s.description      = 'This SDK helps recommend clothing sizes based on user height and weight with optional SwiftUI UI.'
  s.homepage         = 'https://github.com/MSAZone/SizeRecommendationSDK'
  s.screenshots      = "https://raw.githubusercontent.com/MSAZone/SizeRecommendationSDK/refs/heads/main/images/InputScreen.png"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'MSAZone' => 'msaone530@gmail.com' }
  s.source           = { :git => 'https://github.com/MSAZone/SizeRecommendationSDK.git', :tag => s.version.to_s }
  s.ios.deployment_target = '15.0'
  s.swift_versions   = ['5.0']
  s.source_files     = 'Sources/SizeRecommendationSDK/*.{swift}'
end
