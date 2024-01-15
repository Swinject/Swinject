// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "Swinject",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v12),
        .tvOS(.v12),
        .watchOS(.v4),
        .visionOS(.v1)
    ],
    products: [
        .library(name: "Swinject",
                 targets: ["Swinject"]),
        .library(name: "Swinject-Dynamic",
                 type: .dynamic,
                 targets: ["Swinject"]),
    ],
    targets: [
        .target(name: "Swinject",
                path: "Sources"),
        .testTarget(name: "SwinjectTests",
                    dependencies: ["Swinject"]),
    ]
)
