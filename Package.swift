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
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.1.2/gmp-6.3.0.xcframework.zip",
			checksum: "0a1701e5155ffc17782165c8ca592ee93a077e0f5eae56ddc7f7bbdece3f873c"),
		.binaryTarget(
			name:"POCO",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.1.2/poco-1.13.2.xcframework.zip",
			checksum: "862ab50fa646a1c019b1579f3867e2aabb8c503f4e3fa3dfe8994f11d9e3c044"),
		.binaryTarget(
			name:"PSON",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.1.2/pson-1.0.7.xcframework.zip",
			checksum: "0363c442359ff6f1a9f48d7a1ca8146c2be6ee2051dc49612cf72f7c2f883d47"),
		.binaryTarget(
			name:"OpenSSL",
			url:"https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.1.2/openssl-3.0.15.xcframework.zip",
			checksum: "e0a21ef7afaf46e51eae7cd7fc7e19e215a4b9abd8d4fd143f5657acee24151e"),
		.binaryTarget(
			name:"PrivMXEndpoint",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.1.2/privmx-endpoint-2.1.2.xcframework.zip",
			checksum: "809023f0c02fbde826b0d08497c9fe777782d3d6c85ec83671ed27319a6d105a")
	],
	cxxLanguageStandard: .cxx17
)
