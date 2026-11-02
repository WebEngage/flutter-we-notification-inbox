## 2.1.0

- **Swift Package Manager:** added support for `webengage-ios-sdk` **2.x** (WebEngage iOS SDK **7.x**). The supported range is now `1.0.0 ..< 3.0.0`, so both iOS SDK 6.x and 7.x work.
- **CocoaPods:** no change.
- No Dart API changes.
- **Existing SPM apps:** to move to iOS SDK 7.x, update your packages in Xcode (**File ▸ Packages ▸ Update to Latest Package Versions**) or delete `Package.resolved`. If another plugin in your app still limits `webengage-ios-sdk` to 1.x, SPM keeps 1.x until that plugin is updated.

## 2.0.0

- Added Swift Package Manager (SPM) support for iOS.
- Updated minimum iOS deployment target to 13.0.

## 1.0.2

- Fixed an issue with the “Delete All” functionality.

## 1.0.1

- Added missing `namespace` in `android/build.gradle` for AGP 7.x compatibility.

## 1.0.0

- Added support to Notification Inbox
