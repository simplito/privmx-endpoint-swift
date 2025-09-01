// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "privmx-endpoint-swift",
	platforms: [
		.macOS(.v14),
		.iOS(.v16),
	],
	products: [
		.library(
			name: "PrivMXEndpointSwift",
			targets: ["PrivMXEndpointSwift",
					  "PrivMXEndpointSwiftNative",
					  "PrivMXEndpoint",
					  "POCO",
					  "PSON",
					  "GMP",
					  "OpenSSL",
					 ]
		),
	],
	targets: [
		.target(
			name: "PrivMXEndpointSwiftNative",
			dependencies: ["GMP","POCO","PSON","PrivMXEndpoint","OpenSSL"],
			swiftSettings: [.interoperabilityMode(.Cxx)]
		),
		.target(
			name: "PrivMXEndpointSwift",
			dependencies: ["PrivMXEndpointSwiftNative"],
			swiftSettings: [
				.interoperabilityMode(.Cxx),
						   ]),
		.binaryTarget(
			name:"GMP",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.0-rc5/gmp-6.3.0.xcframework.zip",
			checksum: "2a7e88b4a73c43772037ae14100a3ad47060464a8a0c48bfecb29ba3584b6ca3"),
		.binaryTarget(
			name:"POCO",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.0-rc5/poco-1.13.2.xcframework.zip",
			checksum: "6d154cf6734d574b2358cd1d52997c5e4e10f5ae27dd9d2715704b50cd9ccca9"),
		.binaryTarget(
			name:"PSON",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.0-rc5/pson-1.0.7.xcframework.zip",
			checksum: "20bd578fc4f54af200d9915bc7dcd8cc60464b62591140cc25d301a8bae3989a"),
		.binaryTarget(
			name:"OpenSSL",
			url:"https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.0-rc5/openssl-3.0.17.xcframework.zip",
			checksum: "69b9074f3a74805f43288ab71c06db00c9597e940ef0732ffa6ce842b8fae91a"),
		.binaryTarget(
			name:"PrivMXEndpoint",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.0-rc5/privmx-endpoint-v2.6.0-rc5.xcframework.zip",
			checksum: "6f917ab9058382a5f0429884b9099a89603a84487711023f0d799725fd8ab224")

	],
	cxxLanguageStandard: .cxx17
)
