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
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.2.4/gmp-6.3.0.xcframework.zip",
			checksum: "ffaad3ee205ae4cd4b7bd28fcc176a095a66cd731b38f50f1121cec62fa9ec72"),
		.binaryTarget(
			name:"POCO",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.2.4/poco-1.13.2.xcframework.zip",
			checksum: "a6f94eee099c9571bd2e15dd484a1159c55887b7f46ee29d643ab9a310a38114"),
		.binaryTarget(
			name:"PSON",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.2.4/pson-1.0.7.xcframework.zip",
			checksum: "3169b764154456600475deebc01cabad0dd508c74b4458cf020454e10e0ff5e1"),
		.binaryTarget(
			name:"OpenSSL",
			url:"https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.2.4/openssl-3.0.16.xcframework.zip",
			checksum: "d2464decace0e9fec9c64e448d87a99e54bf4ebbc1b8616833cda31184d204c9"),
		.binaryTarget(
			name:"PrivMXEndpoint",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.2.4/privmx-endpoint-2.2.4.xcframework.zip",
			checksum: "a9b2c0bf4348adca4fad290a5cfc235d219a58baea4963bb86fa88dd697b7944")

	],
	cxxLanguageStandard: .cxx17
)
