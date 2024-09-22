// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Modules",
            targets: ["HomeUnit", "NetworkLayer", "Traits"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.7.1"))
    ],
    targets: [
        .target(
            name: "HomeUnit",
            dependencies: [
                "Traits",
                "NetworkLayer",
                .product(name: "SnapKit", package: "SnapKit")
            ]
        ),
        .target(
            name: "NetworkLayer"
        ),
        .target(
            name: "Traits"
        )
    ]
)
