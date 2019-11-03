#
# Be sure to run `pod lib lint MSOSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'MSOSDK'
    s.version          = '1.1.0'
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

    s.public_header_files = 'MSOSDK/*.h'
    s.source_files = 'MSOSDK/*.{h,m}'
    s.dependency 'AFNetworking', '~> 3.2.1'
    s.ios.deployment_target = '9.0'

end
