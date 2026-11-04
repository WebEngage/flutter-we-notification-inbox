## 2.2.0

- **Android Gradle Plugin 9:** supports built-in Kotlin. The plugin applies the Kotlin Gradle Plugin only on AGP 8 and earlier, or when the app sets `android.builtInKotlin=false`, so apps can build with `android.builtInKotlin=true` (Flutter 3.47+). Apps on AGP 7 and 8 keep working as before.
- **Requires Flutter 3.27 or later** (Dart SDK constraint `>=2.18.6 <4.0.0`). Apps on older Flutter versions keep using 2.1.0.
- **Gradle:** the Android build script no longer declares its own Android Gradle Plugin and Kotlin Gradle Plugin versions; it uses the app's. On AGP 7 and 8, or with `android.builtInKotlin=false`, the app must have the Kotlin Gradle Plugin set up, as Flutter's Kotlin app template already does. The script also no longer uses the Groovy `name value` syntax that Gradle 9 deprecates and Gradle 10 removes.
- **compileSdk:** the plugin now compiles against Android API 34 (was 33). If your app compiles against a lower API level, Flutter shows a warning asking you to raise `compileSdk`, which is backward compatible.
- **Android SDK:** now requires WebEngage Android SDK **5.x** (`com.webengage:android-sdk:[5,)`; latest 5.2.0). Apps that already resolve the newest SDK see no change; apps that pinned 4.x must move to 5.x.
- No Dart API changes. No iOS changes.

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
