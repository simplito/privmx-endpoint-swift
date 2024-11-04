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
			url: "https://github.com/simplito/privmx-endpoint-swift/releases/download/2.0.0/gmp-6.2.1.xcframework.zip",
			checksum: "25d0db4cc8863d219a1b62c3e61d8fa39215321e910d12df4abb7338081a1918"),
		.binaryTarget(
			name:"POCO",
			url: "https://github.com/simplito/privmx-endpoint-swift/releases/download/2.0.0/poco-1.10.1-all.xcframework.zip",
			checksum: "21d67cc6a4dce813c46dca47add33f3f5262ffe679c526e2b5732f52d8bb1b54"),
		.binaryTarget(
			name:"PSON",
			url: "https://github.com/simplito/privmx-endpoint-swift/releases/download/2.0.0/pson-1.0.4.xcframework.zip",
			checksum: "e30b244a7a05337fcfa85a700ec7bd90252cdcd23e3daf624296b34261e4dd5a"),
		.binaryTarget(
			name:"OpenSSL",
			url:"https://github.com/simplito/privmx-endpoint-swift/releases/download/2.0.0/openssl-3.0.15.xcframework.zip",
			checksum: "d6206649134affb244bb9deba1193acae01a2f9f28775f357e6749c4dc305725"),
		.binaryTarget(
			name:"PrivMXEndpoint",
			url: "https://github.com/simplito/privmx-endpoint-swift/releases/download/2.0.0/privmx-endpoint-2.0.2.xcframework.zip",
			checksum: "76a15676d6bd368e21139273e3093dbde588f616aec963d7cd74bf3125120137")
	],
	cxxLanguageStandard: .cxx17
)
