// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KituraTodoList",
    products: [
        .library(
            name: "KituraTodoList",
            targets: ["KituraTodoList"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "KituraTodoList",
            dependencies: []),
        .testTarget(
            name: "KituraTodoListTests",
            dependencies: ["KituraTodoList"]),
    ]
)
