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
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.0/gmp-6.3.0.xcframework.zip",
			checksum: "ce6cf0eed23bc77ee42022753e51a0cb3826ab486094c56cf2101b92935b858c"),
		.binaryTarget(
			name:"POCO",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.0/poco-1.13.2.xcframework.zip",
			checksum: "4cf1de72810bcabce2393e023f3aae299775cc68ea7314abc8c9d532f4c2348e"),
		.binaryTarget(
			name:"PSON",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.0/pson-1.0.7.xcframework.zip",
			checksum: "c4a4cbaf063ebfcbb78b7e5396507664caed95be9c5d49013623974260ea1275"),
		.binaryTarget(
			name:"OpenSSL",
			url:"https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.0/openssl-3.0.17.xcframework.zip",
			checksum: "f062d32b63759750c6b38c82f289f686cea8e60eb6a3c9fa87245b9fdaa10c46"),
		.binaryTarget(
			name:"PrivMXEndpoint",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.0/privmx-endpoint-v2.6.0.xcframework.zip",
			checksum: "62e7ce5c1fa193a11a45a449c083821f315686934de064aa6e1e2e8adc945c57")

	],
	cxxLanguageStandard: .cxx17
)
