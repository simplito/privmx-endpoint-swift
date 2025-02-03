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
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.1.4/gmp-6.3.0.xcframework.zip",
			checksum: "e910bb06a5bb0b49fdc0b4331db28fe1e3191501ab22a7cba99a8bfe305034d2"),
		.binaryTarget(
			name:"POCO",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.1.4/poco-1.13.2.xcframework.zip",
			checksum: "32ec46bf140e8b9bfbb19602e7e634b36947862e9e8d8a9d6c7ad0e857212577"),
		.binaryTarget(
			name:"PSON",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.1.4/pson-1.0.7.xcframework.zip",
			checksum: "28fa073df4e451e20baeabcdde4390bfaffe7e650d8e095550b8641c5d386632"),
		.binaryTarget(
			name:"OpenSSL",
			url:"https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.1.4/openssl-3.0.15.xcframework.zip",
			checksum: "ba218fc9486f874810e3793adadde64b83665a3a9a04a736b24a716f13afd4ff"),
		.binaryTarget(
			name:"PrivMXEndpoint",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.1.4/privmx-endpoint-2.1.4.xcframework.zip",
			checksum: "6584f717669910e1c5a6b9a36a6227753cd8303ea81737e8501c0895835d63bd")
	],
	cxxLanguageStandard: .cxx17
)
