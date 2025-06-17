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
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.4/gmp-6.3.0.xcframework.zip",
			checksum: "efc1401449c92ae6c1d04f67e64c9ec38d30a8fc19f1ac3f58e8aa8aa62bc85e"),
		.binaryTarget(
			name:"POCO",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.4/poco-1.13.2.xcframework.zip",
			checksum: "a3bd8ddeeb5c3de506c2d1a8f17d43976dfdd854bb5cf4db1a96156edc891c7c"),
		.binaryTarget(
			name:"PSON",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.4/pson-1.0.7.xcframework.zip",
			checksum: "03ac225a978c9060226b9ce824e38dd8d7bf2abd91de46909d868618e1493bdf"),
		.binaryTarget(
			name:"OpenSSL",
			url:"https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.4/openssl-3.0.16.xcframework.zip",
			checksum: "076d5ea35ce634d97ca796f0c79759739e5c3cd2406a0fbc42e4b492ef97f0f7"),
		.binaryTarget(
			name:"PrivMXEndpoint",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.4/privmx-endpoint-v2.3.4.xcframework.zip",
			checksum: "9d9eb8904613e1808c1e01b2b2ff8187e89c7c037ee1b8b6769d28a28427047b")

	],
	cxxLanguageStandard: .cxx17
)
