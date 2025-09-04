// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SizeRecommendationSDK",
    platforms: [
        .iOS(.v15) // or higher, depending on your SwiftUI requirement
    ],
    products: [
        .library(
            name: "SizeRecommendationSDK",
            targets: ["SizeRecommendationSDK"]
        ),
    ],
    targets: [
        .target(
            name: "SizeRecommendationSDK",
            dependencies: []
        ),
    ]
)
