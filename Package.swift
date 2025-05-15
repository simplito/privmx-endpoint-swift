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
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.0/gmp-6.3.0.xcframework.zip",
			checksum: "c27691aa9731a9d72c80d75f017754b866aa229daa12640459f317893ccfcccb"),
		.binaryTarget(
			name:"POCO",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.0/poco-1.13.2.xcframework.zip",
			checksum: "0144cf94c7b2534ff27cd69ed39f0048f884d68346d453c59632c5c09a21abcf"),
		.binaryTarget(
			name:"PSON",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.0/pson-1.0.7.xcframework.zip",
			checksum: "edbe9f9da703920dbe5434e21124780789bf7e6741c7e1d0e16707249e0cccd2"),
		.binaryTarget(
			name:"OpenSSL",
			url:"https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.0/openssl-3.0.16.xcframework.zip",
			checksum: "b5885a967882562eb25029484575c5406637a2939dd33b4b6716dbe4670399a5"),
		.binaryTarget(
			name:"PrivMXEndpoint",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.0/privmx-endpoint-v2.3.0.xcframework.zip",
			checksum: "0007b9819f5c8688ca5891b5d07a88df51e7e4b13615da32e47f4fdc3100240b")

	],
	cxxLanguageStandard: .cxx17
)
