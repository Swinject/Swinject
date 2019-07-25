// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Swinject",
    products: [
        .library(
            name: "Swinject",
            targets: ["Swinject"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick", from: "2.1.0"),
        .package(url: "https://github.com/Quick/Nimble", from: "8.0.1"),
    ],
    targets: [
        .target(
            name: "Swinject",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "SwinjectTests",
            dependencies: [
                "Quick",
                "Nimble",
                "Swinject",
            ]
        ),
    ]
)
