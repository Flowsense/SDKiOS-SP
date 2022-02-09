// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FlowsenseSDK",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "FlowsenseSDK",
            targets: ["FlowsenseSDK"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .binaryTarget(
            name: "FlowsenseSDK",
            url: "https://raw.githubusercontent.com/Flowsense/SDKiOS-SP/main/frameworks/4.1.1.zip",
            checksum: "db7b6446a9a9532f652afc36145cdcb0183e5f25ca25d5b192ef7ec2f5ba0db6"
        )
    ]
)

