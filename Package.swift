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
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.5/gmp-6.3.0.xcframework.zip",
			checksum: "c99ad30e0a478097ce747a592a4272d4dc7987448f1c9bda3081ea9d87abaa05"),
		.binaryTarget(
			name:"POCO",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.5/poco-1.13.2.xcframework.zip",
			checksum: "896fe383b8cd191a018292ce8ffe1c5e94edc6a49ae9eabbcf1ad6d346b28fa2"),
		.binaryTarget(
			name:"PSON",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.5/pson-1.0.7.xcframework.zip",
			checksum: "1d7636b8a156035376b369ade89e4f553588fb097a851f0b4946116601632125"),
		.binaryTarget(
			name:"OpenSSL",
			url:"https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.5/openssl-3.0.18.xcframework.zip",
			checksum: "be0f951063d9c7bc31df4b391e14ea99688e98a8b5243ac99ebb966f49ff0572"),
		.binaryTarget(
			name:"PrivMXEndpoint",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.5/privmx-endpoint-v2.6.5.xcframework.zip",
			checksum: "acd28515f1f87b3ad3290f98376fe9a1539efe0bee2008dd5260d7e9447bb317")

	],
	cxxLanguageStandard: .cxx17
)
