// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Application",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Application",
            targets: ["Application"]
        )
    ],
    dependencies: [
        .package(
            name: "LocalizationKit",
            path: "../LocalizationKit"
        ),
        .package(
            name: "ServiceKit",
            path: "../ServiceKit"
        ),
        .package(
            name: "InterfaceKit",
            path: "../InterfaceKit"
        )
    ],
    targets: [
        .target(
            name: "Application",
            dependencies: [
                "LocalizationKit",
                "ServiceKit",
                "InterfaceKit"
            ]
        ),
        .testTarget(
            name: "ApplicationTests",
            dependencies: ["Application"]
        )
    ]
)
