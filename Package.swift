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
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.0-rc4/gmp-6.3.0.xcframework.zip",
			checksum: "2149fd1ba4ae44ac1aac9320c4211f137a63c1e9cd919ecbfb9b35d0863e5fcf"),
		.binaryTarget(
			name:"POCO",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.0-rc4/poco-1.13.2.xcframework.zip",
			checksum: "21e632a9f1023f8bfd519611da390fde071cdb01ffcbc357a4f00a11bb71f695"),
		.binaryTarget(
			name:"PSON",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.0-rc4/pson-1.0.7.xcframework.zip",
			checksum: "7de078b6c047faa13522cabaf007d75e19b66d2298546ab82e3eb7c4698049de"),
		.binaryTarget(
			name:"OpenSSL",
			url:"https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.0-rc4/openssl-3.0.17.xcframework.zip",
			checksum: "0b40e6a59d92e0d37bd7f56d1a5df037b82d96f4ab5e245d9b9bb5a9c8a3774f"),
		.binaryTarget(
			name:"PrivMXEndpoint",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.0-rc4/privmx-endpoint-v2.6.0-rc4.xcframework.zip",
			checksum: "2a1d703887bac77b6233d878b61fe99cd2009fa9d98c7aa6c457332c46b96015")

	],
	cxxLanguageStandard: .cxx17
)
