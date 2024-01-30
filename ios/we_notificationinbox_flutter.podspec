
Pod::Spec.new do |s|
  s.name             = 'we_notificationinbox_flutter'
  s.version          = '1.0.0'
  s.summary          = 'WE-NotififcationInbox-Plugin'
  s.description      = <<-DESC
WE-NotififcationInbox-Plugin sdk
                       DESC
  s.homepage         = 'https://webengage.com/'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'WebEngage' => 'mobile@webengage.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'WENotificationInbox','>= 1.1.0'
  s.platform = :ios, '10.0'

  # Flutter.framework does not contain a i386 slice.
  #s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  #s.swift_version = '5.0'
end
