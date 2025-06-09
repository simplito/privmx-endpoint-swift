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
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.3/gmp-6.3.0.xcframework.zip",
			checksum: "0b7cc6ac485e6b8b9f34bd77dfa7797ab87216fe5aa5f84498de50a357caa60d"),
		.binaryTarget(
			name:"POCO",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.3/poco-1.13.2.xcframework.zip",
			checksum: "30aaa0076b1df1147b5e114cdd120a01495b289b4d7bfdd3d77125bd5b70220f"),
		.binaryTarget(
			name:"PSON",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.3/pson-1.0.7.xcframework.zip",
			checksum: "983d46b2f6846914c460c53e8f828e802388e3b33a53293e93d7ccd23cf57f8b"),
		.binaryTarget(
			name:"OpenSSL",
			url:"https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.3/openssl-3.0.16.xcframework.zip",
			checksum: "a03394fb5211e6432913fb0ce3038a41fb4c5ab878ba8d13106aa0611ab6225e"),
		.binaryTarget(
			name:"PrivMXEndpoint",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.3/privmx-endpoint-v2.3.3.xcframework.zip",
			checksum: "871ee4d660e5c2eec9ac3ad8ee656da81d1b040d1b6853fb1a39088544334a0c")

	],
	cxxLanguageStandard: .cxx17
)
