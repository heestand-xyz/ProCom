// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "ProCom",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
    ],
    products: [
        .library(
            name: "ProCom",
            targets: ["ProCom"]),
    ],
    dependencies: [
        .package(url: "https://github.com/orchetect/OSCKit", from: "0.5.0"),
        .package(url: "https://github.com/apple/swift-collections.git", .upToNextMinor(from: "1.0.0")),
    ],
    targets: [
        .target(
            name: "ProCom",
            dependencies: [
                "OSCKit",
                .product(name: "Collections", package: "swift-collections"),
            ]
        ),
        .testTarget(
            name: "ProComTests",
            dependencies: ["ProCom"]),
    ]
)
