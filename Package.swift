// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CBExtensions",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "CommonExtensions", targets: ["CommonExtensions"]),
        .library(name: "SwiftUIExtensions", targets: ["SwiftUIExtensions"]),
        .library(name: "FittedSheet", targets: ["FittedSheet"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "CommonExtensions"),
        .testTarget(name: "CommonExtensionsTests",
                    dependencies: ["CommonExtensions"]),
        
        .target(name: "SwiftUIExtensions"),
        
        .target(name: "FittedSheet",
                dependencies: [ "SwiftUIExtensions" ]),
    ]
)
