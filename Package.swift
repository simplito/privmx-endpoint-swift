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
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.2.1/gmp-6.3.0.xcframework.zip",
			checksum: "6e0d856835a95103f6690134d2dbc9ebdbab1005872c72a8ce1f8abd6507a67a"),
		.binaryTarget(
			name:"POCO",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.2.1/poco-1.13.2.xcframework.zip",
			checksum: "3535c6c2fe0c49e87179b2ad52da14c1660178e2d9c477c05b1503f05e107dc7"),
		.binaryTarget(
			name:"PSON",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.2.1/pson-1.0.7.xcframework.zip",
			checksum: "a038f765888476c599820d66adf55b35c2ba50d9fc9d343a5ea83596ee26bcb2"),
		.binaryTarget(
			name:"OpenSSL",
			url:"https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.2.1/openssl-3.0.15.xcframework.zip",
			checksum: "13afa6838eaa249e0c231b9aa662736d23787cc20030e0694aae506e92c893d8"),
		.binaryTarget(
			name:"PrivMXEndpoint",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.2.1/privmx-endpoint-2.2.1.xcframework.zip",
			checksum: "e9fe48b4afc87fe6c3ae99f5bae60666bab9fb802e0f3de30367b9e36301efe7")

	],
	cxxLanguageStandard: .cxx17
)
