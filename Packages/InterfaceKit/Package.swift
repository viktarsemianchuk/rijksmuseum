// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "InterfaceKit",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "InterfaceKit",
            targets: ["InterfaceKit"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/onevcat/Kingfisher.git",
            from: "7.0.0"
        ),
        .package(name: "StyleKit", path: "../StyleKit")
    ],
    targets: [
        .target(
            name: "InterfaceKit",
            dependencies: [
                .product(name: "Kingfisher", package: "Kingfisher"),
                .product(name: "StyleKit", package: "StyleKit")
            ]
        )
    ]
)
