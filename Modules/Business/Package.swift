// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Business",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "Business",
            targets: ["Business"]),
    ],
    dependencies: [
        .package(path: "../Common/"),
    ],
    targets: [
        .target(
            name: "Business",
            dependencies: [
                .product(name: "Common", package: "Common")
            ]),
        .testTarget(
            name: "BusinessTests",
            dependencies: ["Business"]),
    ]
)
