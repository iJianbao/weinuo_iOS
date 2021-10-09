#
#  Be sure to run `pod spec lint TTTAttributedLabel.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "TTTAttributedLabel"
  s.version      = "0.0.1"
  s.summary      = "A short description of TTTAttributedLabel."
  s.description  = <<-DESC
                      TTTAttributedLabel Tools
                   DESC

  s.author             = { "loobot" => "loobot" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "", :tag => "0.0.1" }

  s.source_files  = "TTTAttributedLabel","**/*.{h,m}"
  s.public_header_files = "**/*.h"

  s.homepage     = "http://www.loobot.com"
  s.license      = { :type => "BSD", :file => "LICENSE" }

end
