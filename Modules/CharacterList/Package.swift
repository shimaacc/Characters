// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CharacterList",
    platforms: [
            .iOS(.v16)
    ],
    products: [
        .library(
            name: "CharacterList",
            targets: ["CharacterList"]),
    ],
    dependencies: [
        .package(path: "../Business/"),
        .package(path: "../Common/"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.0.0"),
    ],
    targets: [
        .target(
            name: "CharacterList",
            dependencies: [
                .product(name: "Business", package: "Business"),
                .product(name: "Kingfisher", package: "Kingfisher"),
                .product(name: "Common", package: "Common")
            ]),
        .testTarget(
            name: "CharacterListTests",
            dependencies: ["CharacterList"]),
    ]
)
