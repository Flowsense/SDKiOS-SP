// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "iOSFlowsense",
    platforms: [.iOS(.v11)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "iOSFlowsense",
            targets: ["iOSFlowsenseTargets"]),
    ],
    dependencies: [
        .package(name:"AWSiOSSDKV2", url: "https://github.com/aws-amplify/aws-sdk-ios-spm.git", branch: "main")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .binaryTarget(
            name: "FlowsenseSDK",
            url: "https://github.com/Flowsense/SDKiOS-SP/releases/download/4.1.1/SDK_4.1.1.zip",
            checksum: "57f37eadba63beef3f5782992f538fbf0464f59a902a0e007e91c8f0710e420b"
        ),
        .target(name: "iOSFlowsenseTargets",
                dependencies: [
                    .target(name: "FlowsenseSDK"),
                    .product(name: "AWSCore", package: "AWSiOSSDKV2"),
                    .product(name: "AWSKinesis", package: "AWSiOSSDKV2")
                ],
                path: "Sources")
    ]
)
