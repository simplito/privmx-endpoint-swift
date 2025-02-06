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
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.2.2/gmp-6.3.0.xcframework.zip",
			checksum: "29b65d41f28ea89bbe63d7bb50b1c6078843fe7c240381c3e1230589ae73b544"),
		.binaryTarget(
			name:"POCO",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.2.2/poco-1.13.2.xcframework.zip",
			checksum: "79539286f4f95daeecfb259d7e1cd79f87abc50d97792f58d711e059b8b0528a"),
		.binaryTarget(
			name:"PSON",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.2.2/pson-1.0.7.xcframework.zip",
			checksum: "7ad8708edd1048f0cf600148f512c1e2770d97c4eea96d0596d359c0de0e0738"),
		.binaryTarget(
			name:"OpenSSL",
			url:"https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.2.2/openssl-3.0.15.xcframework.zip",
			checksum: "bc3b541d07dfd4ab43c77e35d184711484730ca5a12c88aeff03f74b58926695"),
		.binaryTarget(
			name:"PrivMXEndpoint",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.2.2/privmx-endpoint-2.2.2.xcframework.zip",
			checksum: "85b6d01f123b1dd397f0990f2c27fd49a6ac66b2a47828b52072a51114a900b0")

	],
	cxxLanguageStandard: .cxx17
)
