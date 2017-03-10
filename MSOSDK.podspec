#
# Be sure to run `pod lib lint MSOSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MSOSDK'
  s.version          = '0.1.0'
  s.summary          = 'A short description of MSOSDK.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://https://github.com/logicielInc/MSOSDK'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jsetting32' => 'jsetting32@yahoo.com' }
  s.source           = { :git => 'https://github.com/logicielInc/MSOSDK.git', :tag => s.version.to_s }
  s.requires_arc = true

  s.public_header_files = 'MSOSDK/MSOSDK.h'
  s.source_files = 'MSOSDK/MSOSDK.h'

s.subspec 'External' do |ss|
ss.source_files = 'External/*'
ss.public_header_files = 'External/*'
end

  s.subspec 'Categories' do |ss|
    ss.dependency 'GTMNSStringHTMLAdditions'

    ss.source_files = 'MSOSDK/*+MSOSDKAdditions.{h,m}'
    ss.public_header_files = 'MSOSDK/*+MSOSDKAdditions.{h,m}'
  end

  s.subspec 'Objects' do |ss|
    ss.dependency 'SMXMLDocument'

    ss.source_files = 'MSOSDK/MSOSDKResponse*.{h,m}'
    ss.public_header_files = 'MSOSDK/MSOSDKResponse*.{h,m}'
  end

  s.subspec 'Master' do |ss|
    ss.dependency 'MSOSDK/Categories'
    ss.dependency 'AFNetworking'
    ss.dependency 'MSOSDK/External'

    ss.source_files = 'MSOSDK/MSOSDKMaster.{h,m}'
    ss.public_header_files = 'MSOSDK/MSOSDKMaster.{h,m}'
  end



s.subspec 'Constants' do |ss|
ss.source_files = 'MSOSDK/MSOSDKConstants.{h,m}'
ss.public_header_files = 'MSOSDK/MSOSDKConstants.{h,m}'
end


s.subspec 'Networking' do |ss|
ss.dependency 'MSOSDK/Objects'
    ss.dependency 'MSOSDK/Master'
ss.dependency 'MSOSDK/External'


ss.source_files = 'MSOSDK/MSOSDK+*'
ss.public_header_files = 'MSOSDK/MSOSDK+*'
end

  s.ios.deployment_target = '8.0'

end
