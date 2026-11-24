// swift-tools-version:6.0.0

import PackageDescription

let package = Package(
    name: "Swinject",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v15),
        .tvOS(.v12),
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
