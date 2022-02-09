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
        binaryTarget(
            name: "FlowsenseSDK",
            url: "https://raw.githubusercontent.com/Flowsense/SDKiOS-SP/main/frameworks/4.1.1.zip",
            checksum: "328153d7419c1c2e61d830097d61fe2d1a50f4e0e7245c2f2c0f2c09777d7b15"
        )
    ]
)
