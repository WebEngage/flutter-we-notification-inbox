// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "we_notificationinbox_flutter",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(name: "we-notificationinbox-flutter", targets: ["we_notificationinbox_flutter"])
    ],
    dependencies: [
        .package(url: "https://github.com/WebEngage/webengage-ios-sdk.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "we_notificationinbox_flutter",
            dependencies: [
                .product(name: "WebEngageNotificationInbox", package: "webengage-ios-sdk")
            ]
        )
    ]
)
