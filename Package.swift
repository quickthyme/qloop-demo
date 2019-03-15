// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "QLoop-Demo",
    dependencies: [
        .package(url: "https://github.com/quickthyme/qloop.git", from: "0.1.0"),
    ],
    targets: [
        .target(name: "QLoop-Demo", dependencies: ["QLoop"]),
    ]
)

