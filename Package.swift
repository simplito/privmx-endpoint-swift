// swift-tools-version: 6.1
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
			cxxSettings: [.headerSearchPath("include")],
			swiftSettings: [.interoperabilityMode(.Cxx)],
		),
		.target(
			name: "PrivMXEndpointSwift",
			dependencies: [
				"PrivMXEndpointSwiftNative",
			],
			swiftSettings: [
				.interoperabilityMode(.Cxx),
			]),
		.binaryTarget(
			name:"GMP",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.7.3/gmp-6.3.0.xcframework.zip",
			checksum: "cee9862212b00a0dc935a1eac8f1f538778928daec587da294836c2c9fee5c85"),
		.binaryTarget(
			name:"POCO",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.7.3/poco-1.13.2.xcframework.zip",
			checksum: "b1ed7298688bd2c6a040c98d6d71cea28acc245d62c3e18b43711c0dfad6b70c"),
		.binaryTarget(
			name:"PSON",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.7.3/pson-1.0.7.xcframework.zip",
			checksum: "c67be747660f0af237e55cdc7c96cc5e9567b8507a13d5709c0cbffea0fc5b18"),
		.binaryTarget(
			name:"OpenSSL",
			url:"https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.7.3/openssl-3.0.18.xcframework.zip",
			checksum: "26d44cdb4d3b42894e79e6230509934d4710c8306b2188bf4f478876b0187513"),
		.binaryTarget(
			name:"PrivMXEndpoint",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.7.3/privmx-endpoint-v2.7.3.xcframework.zip",
			checksum: "a98c06fb7d653efc0d805a28550b7604bd1d3baa2576a74bae00b021b762d089")

	],
	cxxLanguageStandard: .cxx17
)

