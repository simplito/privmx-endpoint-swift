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
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.1.1/gmp-6.3.0.xcframework.zip",
			checksum: "b5e9bf615388678673039154e9c211f1ddc85a23b696e7f06d39a2960c2bfbba"),
		.binaryTarget(
			name:"POCO",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.1.1/poco-1.13.3.xcframework.zip",
			checksum: "89882f0bda4715af2a73363fd5299bd6fbdaa6932e015e2a1015d6bf0a3ed7e1"),
		.binaryTarget(
			name:"PSON",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.1.1/pson-1.0.7.xcframework.zip",
			checksum: "6a7c1a660080caece35b3aaf6932c5d412e87268301e5dbe0e34e606d41db8ed"),
		.binaryTarget(
			name:"OpenSSL",
			url:"https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.1.1/openssl-3.0.15.xcframework.zip",
			checksum: "f97ccedfdb6c29f8f8ee9e2c28c3eba17f21cfb678fa87e40a3eb7a26a28701b"),
		.binaryTarget(
			name:"PrivMXEndpoint",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.1.1/privmx-endpoint-2.1.1.xcframework.zip",
			checksum: "dd4574a382b8d2d5c744be251689d95374d22ed96abe36804973fc9edd4961bb")
	],
	cxxLanguageStandard: .cxx17
)
