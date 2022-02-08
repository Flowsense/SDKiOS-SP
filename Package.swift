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
            url: "https://raw.githubusercontent.com/Flowsense/XCFrameworks_iOS/main/frameworks/4.1.1.zip",
            checksum: "a9325298801b433529fdadc87b6cbbeec2efa57dc525f0835e94a0482c966e10"
        )
    ]
)
