// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Swinject",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Swinject",
            targets: ["Swinject"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick", from: "2.1.0"),
        .package(url: "https://github.com/Quick/Nimble", from: "8.0.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Swinject",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "SwinjectTests",
            dependencies: [
                "Quick",
                "Nimble",
                "Swinject"
            ])
    ]
)
