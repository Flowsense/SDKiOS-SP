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
    dependencies: [
        .package(
            url: "https://github.com/aws-amplify/aws-sdk-ios-spm",
            .branch("main")
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .binaryTarget(
            name: "FlowsenseSDK",
            url: "https://raw.githubusercontent.com/Flowsense/SDKiOS-SP/main/frameworks/4.1.1.zip",
            checksum: "ac1dc4f7f470eb0609c52bf704927dcbba99aa47022dc4a66c2564ce951ecbcd"
        )
    ]
)

