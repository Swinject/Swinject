// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Swinject",
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
    ]
)
