// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "LoadableImageView",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "LoadableImageView",
            targets: ["LoadableImageView"]),
    ],
    dependencies: [
        .package(url: "https://github.com/anconaesselmann/LoadableView", from: "0.3.12"),
    ],
    targets: [
        .target(
            name: "LoadableImageView",
            dependencies: ["LoadableView"]
        ),
        .testTarget(
            name: "LoadableImageViewTests",
            dependencies: ["LoadableImageView"]),
    ]
)
