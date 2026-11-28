// swift-tools-version:6.0.0

import PackageDescription

let package = Package(
    name: "Swinject",
    platforms: [
        .macOS(.v12),
        .iOS(.v15),
        .tvOS(.v15),
        .watchOS(.v9),
        .visionOS(.v1)
    ],
    products: [
        .library(name: "Swinject",
                 targets: ["Swinject"]),
    ],
    targets: [
        .target(name: "Swinject",
                path: "Sources"),
        .testTarget(name: "SwinjectTests",
                    dependencies: ["Swinject"]),
    ]
)
