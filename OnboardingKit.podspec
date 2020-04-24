#
#  Be sure to run `pod spec lint OnboardingKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name           = 'OnboardingKit'
  spec.version        = '0.0.6'
  spec.summary        = 'A simple and interactive framework for making iOS onboarding experience easy and fun!'
  spec.homepage       = 'https://github.com/Athlee/OnboardingKit'
  spec.license        = { :type => 'MIT', :file => 'LICENSE' }
  spec.author         = { 'Eugene Mozharovsky' => 'mozharovsky@live.com' }
  spec.source         = { :git => 'https://github.com/Athlee/OnboardingKit.git', :tag => spec.version.to_s }
  spec.source_files   = 'Source/**/*.swift'
  spec.requires_arc   = true
  spec.swift_versions = ['5.0']
  
  spec.ios.deployment_target = '10.0'

end
