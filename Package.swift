// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KituraTodoList",
    products: [
        .executable(name: "KituraTodoList", targets: ["KituraTodoList"]),
        .library(name: "KituraTodoListCore", targets: ["KituraTodoListCore"]),
    ],
    dependencies: [
      .package(url: "https://github.com/IBM-Swift/Kitura.git", from: "1.7.0"),
      .package(url: "https://github.com/IBM-Swift/HeliumLogger.git",  from: "1.6.1"),
    ],
    targets: [
        .target(
            name: "KituraTodoListCore",
            dependencies: [
                "HeliumLogger",
                "Kitura",
            ]),
        .target(
            name: "KituraTodoList",
            dependencies: [
                .target(name: "KituraTodoListCore"),
            ]),
        .testTarget(
            name: "KituraTodoListTests",
            dependencies: [
                .target(name: "KituraTodoListCore"),
            ]),
    ],
    swiftLanguageVersions: [4]
)
