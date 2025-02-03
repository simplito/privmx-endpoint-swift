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
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.2.0/gmp-6.3.0.xcframework.zip",
			checksum: "afe394297118b3a62df848ac2edc816687178b58032eb2f81d79e99e1bb7644a"),
		.binaryTarget(
			name:"POCO",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.2.0/poco-1.13.2.xcframework.zip",
			checksum: "4aab8e7e08e6bfee399be7d143b835f24c0f3ad974a49abd5c5e4bef40a587fb"),
		.binaryTarget(
			name:"PSON",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.2.0/pson-1.0.7.xcframework.zip",
			checksum: "105df5a8e587d37e6a598fb7f9d203f91a435eade1772c7c791ad58479095f60"),
		.binaryTarget(
			name:"OpenSSL",
			url:"https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.2.0/openssl-3.0.15.xcframework.zip",
			checksum: "f040129a6bbf6ce39babb61f697d1f4a54a07ef56ab038b823672b784a6a9f29"),
		.binaryTarget(
			name:"PrivMXEndpoint",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.2.0/privmx-endpoint-2.2.0.xcframework.zip",
			checksum: "81de4840b8860253ae26005ad6c050642c3c2545c7046992134c4d09815ec465")
	],
	cxxLanguageStandard: .cxx17
)
