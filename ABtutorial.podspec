#
# Be sure to run `pod lib lint ABtutorial.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ABtutorial'
  s.version          = '0.1.0'
  s.summary          = 'A customizable tutorial onboarding.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    'A customizable tutorial onboarding with Lottie animations.'
                       DESC
                       
  s.homepage         = 'https://abenergie.visualstudio.com/ABtutorial.ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Luigi Aiello' => 'luigi.aiello@abenergie.it', 'Francesco Leoni' => 'francesco.leoni@abenergie.it' }
  s.source           = { :git => 'https://abenergie.visualstudio.com/_git/ABtutorial.ios', :tag => 'v0.1.0' }
  s.social_media_url = 'https://github.com/fraleo2406'
  s.social_media_url = 'https://github.com/mo3bius'
                       
  s.source_files = 'Source/**/*.swift'
  s.swift_version = '5.2'
  s.platform = :ios, '11.0'
  
  s.dependency 'lottie-ios', '~> 3.1.9'
  
  # s.resource_bundles = {
  #   'ABtutorial' => ['ABtutorial/Assets/*.png']
  # }

  # s.frameworks = 'UIKit', 'MapKit'
end
