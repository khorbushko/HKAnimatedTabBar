Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '11.0'
s.name = "HKAnimatedTabBar"
s.summary = "HKAnimatedTabBar - animated tabBar component with custom buttons and transition animation"
s.requires_arc = true
s.version = "0.0.5"
s.license = 'MIT'
s.author = { "Kyryl" => "kirill.ge@gmail.com" }
s.homepage = "https://github.com/kirillgorbushko/HKAnimatedTabBar"
s.source = { :git => "https://github.com/kirillgorbushko/HKAnimatedTabBar.git",
                :tag => "#{s.version}" }
s.framework = "UIKit"
s.source_files = "HKAnimatedTabBar/Source/**/*.{swift}"
s.resources = "HKAnimatedTabBar/Source/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"
s.swift_version = "5.1"

end
