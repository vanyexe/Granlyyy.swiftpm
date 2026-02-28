// swift-tools-version: 6.2

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "Granly",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .iOSApplication(
            name: "Granly",
            targets: ["AppModule"],
            bundleIdentifier: "com.vany.Granly",
            teamIdentifier: "K874F584C7",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .asset("AppIcon"),
            accentColor: .presetColor(.mint),
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
            appCategory: .education
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: "."
        )
    ],
    swiftLanguageVersions: [.version("6")]
)