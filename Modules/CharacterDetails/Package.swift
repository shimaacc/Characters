// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CharacterDetails",
    platforms: [
            .iOS(.v16)
    ],
    products: [
        .library(
            name: "CharacterDetails",
            targets: ["CharacterDetails"]),
    ],
    dependencies: [
        .package(path: "../Common/"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.0.0"),
    ],
    targets: [
        .target(
            name: "CharacterDetails",
            dependencies: [
                .product(name: "Common", package: "Common"),
                .product(name: "Kingfisher", package: "Kingfisher")
            ]),
        .testTarget(
            name: "CharacterDetailsTests",
            dependencies: ["CharacterDetails"]),
    ]
)
