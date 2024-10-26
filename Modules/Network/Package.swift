// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Network",
    platforms: [
            .iOS(.v16)
    ],
    products: [
        .library(
            name: "Network",
            targets: ["Network"]),
    ],
    dependencies: [
        .package(path: "../Common/"),
    ],
    targets: [
        .target(
            name: "Network",
            dependencies: [
                .product(name: "Common", package: "Common")
            ]),
        .testTarget(
            name: "NetworkTests",
            dependencies: ["Network"]),
    ]
)
