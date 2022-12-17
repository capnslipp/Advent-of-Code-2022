// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Elf",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Elf",
            targets: ["Elf"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "metacosm", path: "../../../metacosm/"),
        .package(url: "https://github.com/capnslipp/With.git", branch: "master"),
        .package(url: "https://github.com/capnslipp/NilCoalescingAssignmentOperators.git", branch: "master"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Elf",
            dependencies: [ "metacosm", "With", "NilCoalescingAssignmentOperators" ]),
        .testTarget(
            name: "ElfTests",
            dependencies: ["Elf"]),
    ]
)
