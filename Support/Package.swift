// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "AoC2022Support",
	products: [
		.library(name: "AoC2022Support", targets: ["AoC2022Support"]),
	],
	dependencies: [
		.package(name: "metacosm", path: "../../metacosm/"),
	],
	targets: [
		.target(name: "AoC2022Support", dependencies: [ "metacosm" ], path: "./"),
	]
)
