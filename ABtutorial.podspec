#
# Be sure to run `pod lib lint ABtutorial.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ABtutorial'
  s.version          = '1.0.0'
  s.summary          = 'Onboarding personalizzabile per mostrare tutorial.'

  s.description      = <<-DESC
    'La libreria ABtutorial permette la visualizzazione di mini-tutorial che spiegano specifiche funzionalità sulle app del gruppo ABenergie.'
                       DESC
                       
  s.homepage         = 'https://abenergie.visualstudio.com/ABtutorial.ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Luigi Aiello' => 'luigi.aiello@abenergie.it', 'Francesco Leoni' => 'francesco.leoni@abenergie.it' }
  s.source           = { :git => 'https://abenergie.visualstudio.com/_git/ABtutorial.ios', :tag => 'v1.0.0' }
  s.social_media_url = 'https://github.com/fraleo2406'
  s.social_media_url = 'https://github.com/mo3bius'
                       
  s.source_files = 'Source/**/*.swift'
  s.swift_version = '5.2'
  s.platform = :ios, '11.0'
  
  s.dependency 'lottie-ios', '~> 3.1.9'
end
