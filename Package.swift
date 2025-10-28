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
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.3/gmp-6.3.0.xcframework.zip",
			checksum: "5bf453b678892015baf92408696842a33b9e424fbc1e2a834c41ac1b5d7df749"),
		.binaryTarget(
			name:"POCO",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.3/poco-1.13.2.xcframework.zip",
			checksum: "89acb128056b11bf53d645a662d513f36f85f1ac84d7e82cb31810798171570d"),
		.binaryTarget(
			name:"PSON",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.3/pson-1.0.7.xcframework.zip",
			checksum: "1608d7287a472bef1a1c7129282119ea5a4f8ab51c97d4045021e5cad155c41e"),
		.binaryTarget(
			name:"OpenSSL",
			url:"https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.3/openssl-3.0.18.xcframework.zip",
			checksum: "38906abce4f2592df0e2514b1846409d977747f82095caba29a4552d4e4e137d"),
		.binaryTarget(
			name:"PrivMXEndpoint",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.3/privmx-endpoint-v2.6.3.xcframework.zip",
			checksum: "dcb5665f3719e42e2e90ae233d1d025bfa743d9e1a81027959ec3766b3f0b9b2")

	],
	cxxLanguageStandard: .cxx17
)
