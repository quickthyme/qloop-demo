// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "QLoop-Demo",
    dependencies: [
        .package(url: "https://github.com/quickthyme/qloop.git", from: "0.0.8"),
    ],
    targets: [
        .target(name: "QLoop-Demo", dependencies: ["QLoop"]),
    ]
)

