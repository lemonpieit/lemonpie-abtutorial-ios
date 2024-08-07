// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ABtutorial",
    platforms: [.iOS(.v12)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ABtutorial",
            targets: ["ABtutorial"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
			.package(url: "https://github.com/airbnb/lottie-ios", .exact("4.4.1"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "ABtutorial",
            dependencies: [.product(name: "Lottie", package: "lottie-ios")],
            path: "Source",
            resources: [
              .process("Assets/Colors.xcassets")
            ])
    ]
)
