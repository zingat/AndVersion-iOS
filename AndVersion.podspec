#
# Be sure to run `pod lib lint AndVersion.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AndVersion'
  s.version          = '1.2.2'
  s.summary          = 'This library checks updates on Apple Store by using given json file url. If wanted, the library also lists whats new info to the users when a new version is available.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This is the library that checks updates on Apple Store according to json file from the given url address. This library can work in three modes. Callback mode, autopilot mode and hybrid mode.
                       DESC

  s.homepage         = 'https://github.com/zingat/AndVersion-iOS'
  s.screenshots     = 'https://raw.githubusercontent.com/zingat/AndVersion-iOS/master/Example/images/must_update.png', 'https://raw.githubusercontent.com/zingat/AndVersion-iOS/master/Example/images/need_to_update.png', 'https://raw.githubusercontent.com/zingat/AndVersion-iOS/master/Example/images/new_version_is_running.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kadirkemal' => 'kkdursun@yahoo.com' }
  s.source           = { :git => 'https://github.com/zingat/AndVersion-iOS.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'AndVersion/Classes/**/*'
  
  # s.resource_bundles = {
  #   'AndVersion' => ['AndVersion/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
