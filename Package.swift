// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "privmx-endpoint-swift",
	platforms: [
		.macOS(.v14),
		.iOS(.v16),
		.tvOS(.v16),
		.watchOS(.v9)
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
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.1.3/gmp-6.3.0.xcframework.zip",
			checksum: "858b66cd6730764cf0a7189794c36f827674dac69756a337734dbb72571051ae"),
		.binaryTarget(
			name:"POCO",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.1.3/poco-1.13.2.xcframework.zip",
			checksum: "9e167207255ecccedc0830625cc68b68668330decda67d702211671058f9917a"),
		.binaryTarget(
			name:"PSON",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.1.3/pson-1.0.7.xcframework.zip",
			checksum: "eb004b3f8e60ca5892bd46eded76ca7e419caa6c549c4698dd8ca5edc53f1066"),
		.binaryTarget(
			name:"OpenSSL",
			url:"https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.1.3/openssl-3.0.15.xcframework.zip",
			checksum: "e3159c6736d647c6f13acd9cc35227cd9d6e25010805f88e24676bc7cf174b60"),
		.binaryTarget(
			name:"PrivMXEndpoint",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.1.3/privmx-endpoint-2.1.3.xcframework.zip",
			checksum: "54a54edfca827b79d1cd194edef569d87c18035a3c5e9d2f5be4deaf127d8adf")
	],
	cxxLanguageStandard: .cxx17
)
