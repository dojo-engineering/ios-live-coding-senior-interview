// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "FeatureFlags",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(name: "FeatureFlags", targets: ["FeatureFlags"])
    ],
    targets: [
        .target(name: "FeatureFlags"),
        .testTarget(name: "FeatureFlagsTests", dependencies: ["FeatureFlags"])
    ]
)
