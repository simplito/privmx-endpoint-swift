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
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.1/gmp-6.3.0.xcframework.zip",
			checksum: "9181e7302810d441ef337981d77aed0b2ac1908347b25017fc15bc186fcb2741"),
		.binaryTarget(
			name:"POCO",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.1/poco-1.13.2.xcframework.zip",
			checksum: "7712d7f6e7630a78fc38a047c0bab6ecc11296ab254d3d00f441e6e93a83b112"),
		.binaryTarget(
			name:"PSON",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.1/pson-1.0.7.xcframework.zip",
			checksum: "388808c4a8809404e8194155bb7b44d0602d44949e55475cde8d5f7c36269cfb"),
		.binaryTarget(
			name:"OpenSSL",
			url:"https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.1/openssl-3.0.16.xcframework.zip",
			checksum: "68ab416affc72bd01f0f1b4d8bb75f31aab2091e97abf9b7c10ecc688b5de443"),
		.binaryTarget(
			name:"PrivMXEndpoint",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.1/privmx-endpoint-v2.3.1.xcframework.zip",
			checksum: "adb88feea7af93ff3b60719e47ff7140242cf38184077d68bb718e450ca1b34a")

	],
	cxxLanguageStandard: .cxx17
)
