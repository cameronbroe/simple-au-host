// swift-tools-version: 5.6

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "SimpleAUHost",
    platforms: [
        .iOS("15.2")
    ],
    products: [
        .iOSApplication(
            name: "SimpleAUHost",
            targets: ["AppModule"],
            bundleIdentifier: "com.cameronbroe.simple-au-host",
            teamIdentifier: "794G2HFN44",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .note),
            accentColor: .presetColor(.blue),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ],
            appCategory: .music
        )
    ],
    dependencies: [
        .package(url: "https://github.com/AudioKit/AudioKitUI", "0.1.5"..<"1.0.0")
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            dependencies: [
                .product(name: "AudioKitUI", package: "AudioKitUI")
            ],
            path: "."
        )
    ]
)
