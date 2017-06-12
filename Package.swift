// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KituraTodoList",
    products: [
        .executable(
            name: "KituraTodoList",
            targets: ["KituraTodoList"]),
    ],
    dependencies: [
      .package(url: "https://github.com/IBM-Swift/Kitura.git", from: "1.7.0"),
      .package(url: "https://github.com/IBM-Swift/HeliumLogger.git",  from: "1.6.1"),
    ],
    targets: [
        .target(
            name: "KituraTodoList",
            dependencies: [
                "Kitura",
            ]),
        .testTarget(
            name: "KituraTodoListTests",
            dependencies: ["KituraTodoList"]),
    ],
    swiftLanguageVersions: [4]
)
