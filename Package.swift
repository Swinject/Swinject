// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Swinject",
    products: [
        .library(name: "Swinject",
                 targets: ["Swinject"]),
    ],
    targets: [
        .target(name: "Swinject",
                path: "Sources"),
    ]
)
