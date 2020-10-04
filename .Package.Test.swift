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
        .package(url: "https://github.com/Quick/Quick", from: "3.0.0"),
        .package(url: "https://github.com/Quick/Nimble", from: "9.0.0"),
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
