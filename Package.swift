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
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.2.5/gmp-6.3.0.xcframework.zip",
			checksum: "cfbe693ed2f36a17eccfbc4bae0426aee09679efb76858f5e19469009cb8b735"),
		.binaryTarget(
			name:"POCO",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.2.5/poco-1.13.2.xcframework.zip",
			checksum: "f0b2be10f310bc78ee0e2b04fff241a784fbc0c1450109d27060672cd9368592"),
		.binaryTarget(
			name:"PSON",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.2.5/pson-1.0.7.xcframework.zip",
			checksum: "5f83717126e4052e7408ace33179e9162c91752700114dffffc77791128dc7bf"),
		.binaryTarget(
			name:"OpenSSL",
			url:"https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.2.5/openssl-3.0.16.xcframework.zip",
			checksum: "a5d84f90f84e99d5dd8243529517c3e17972c28fb3edbb61bd3c1860487b7442"),
		.binaryTarget(
			name:"PrivMXEndpoint",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.2.5/privmx-endpoint-2.2.5.xcframework.zip",
			checksum: "8d09c13bd7636425dfa4e724b8d20bc80b7d6d60e058ebf67c5a80466ce09c4a")

	],
	cxxLanguageStandard: .cxx17
)
