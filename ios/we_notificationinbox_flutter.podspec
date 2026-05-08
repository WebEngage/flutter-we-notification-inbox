
Pod::Spec.new do |s|
  s.name             = 'we_notificationinbox_flutter'
  s.version          = '2.0.0'
  s.summary          = 'WE-NotififcationInbox-Plugin'
  s.description      = <<-DESC
WE-NotififcationInbox-Plugin sdk
                       DESC
  s.homepage         = 'https://webengage.com/'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'WebEngage' => 'mobile@webengage.com' }
  s.source           = { :path => '.' }
  s.source_files = 'we_notificationinbox_flutter/Sources/we_notificationinbox_flutter/**/*.swift'
  s.dependency 'Flutter'
  s.dependency 'WENotificationInbox','>= 1.1.0'
  s.platform = :ios, '13.0'
  s.swift_version = '5.0'
end
