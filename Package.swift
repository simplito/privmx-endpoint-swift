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
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.5.2/gmp-6.3.0.xcframework.zip",
			checksum: "ff30b1bdf10acd43f85c925b13f9f6127a22b405de5233b7eb267f271514a373"),
		.binaryTarget(
			name:"POCO",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.5.2/poco-1.13.2.xcframework.zip",
			checksum: "e00ab7a95c6832989fb7cd46e43e6a880dfb5cd91a37b8a23778a76297c0190b"),
		.binaryTarget(
			name:"PSON",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.5.2/pson-1.0.7.xcframework.zip",
			checksum: "fc15bf548ac336b1cfee8fd444e5c4b7d44713fa4db7488ff9a8d67bd20595a5"),
		.binaryTarget(
			name:"OpenSSL",
			url:"https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.5.2/openssl-3.0.16.xcframework.zip",
			checksum: "83166c02fcf34f709db0e783a72e808dc40c00d6c992c4ea0e4db216a5def8e9"),
		.binaryTarget(
			name:"PrivMXEndpoint",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.5.2/privmx-endpoint-v2.5.2.xcframework.zip",
			checksum: "53d33d41b3840bf8546c65bb89068a3cfb6679846fdca4413e9a61788dd0172d")

	],
	cxxLanguageStandard: .cxx17
)
