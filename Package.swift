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
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.0-rc2/gmp-6.3.0.xcframework.zip",
			checksum: "479846db8364ca20969df4517fc2df88e9e5e89aa019b522376612c47c87f432"),
		.binaryTarget(
			name:"POCO",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.0-rc2/poco-1.13.2.xcframework.zip",
			checksum: "3cc9355ce344e4b2cb592300e47321919ef658e042a7f3e4c2736b268b783c20"),
		.binaryTarget(
			name:"PSON",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.0-rc2/pson-1.0.7.xcframework.zip",
			checksum: "d99d93a0451f83caf8a5e0d272eb88389a7a72c74cafd1a517f47343035a0ba9"),
		.binaryTarget(
			name:"OpenSSL",
			url:"https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.0-rc2/openssl-3.0.16.xcframework.zip",
			checksum: "f34c29974a665467a9e8511f64d48a4076a2ec473575f60058b00d39c12e664c"),
		.binaryTarget(
			name:"PrivMXEndpoint",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.0-rc2/privmx-endpoint-2.3.0-rc2.xcframework.zip",
			checksum: "d6d3ed27e1f4f5413bd1513b53c31044786ba890f5f4c62e24efb5bd9fef9544")

	],
	cxxLanguageStandard: .cxx17
)
