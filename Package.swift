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
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.4.0-rc1/gmp-6.3.0.xcframework.zip",
			checksum: "cd0df28773537b47ed5b160bbba43529523296827ef0c42c48791cd8fa97ebd9"),
		.binaryTarget(
			name:"POCO",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.4.0-rc1/poco-1.13.2.xcframework.zip",
			checksum: "75f34b418e6e4f979cf587d0c0eba763d4462c8f37753fbe9d315667abf80c23"),
		.binaryTarget(
			name:"PSON",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.4.0-rc1/pson-1.0.7.xcframework.zip",
			checksum: "d496354e6a4d4921e7e1f0f4b55042d5374a1aa6c67902ce7b10d1403c99fb09"),
		.binaryTarget(
			name:"OpenSSL",
			url:"https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.4.0-rc1/openssl-3.0.16.xcframework.zip",
			checksum: "944a709304c956d29f7bd282c81e811153450636a0f950c39605d8997bd636cd"),
		.binaryTarget(
			name:"PrivMXEndpoint",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.4.0-rc1/privmx-endpoint-v2.4.0-rc1.xcframework.zip",
			checksum: "e0a584bde18fdbef9b49732d3724d2d3fa38e658b8c0b6b1a7fcb8f31541057a")

	],
	cxxLanguageStandard: .cxx17
)
