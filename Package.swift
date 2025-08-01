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
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.0-rc3/gmp-6.3.0.xcframework.zip",
			checksum: "7dd3adb5067c8ad76dabd95291b6910a4f75e555974c3cf5f8d00bc2b3b2049f"),
		.binaryTarget(
			name:"POCO",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.0-rc3/poco-1.13.2.xcframework.zip",
			checksum: "c89b0ded87b2537a950a38704d19127b63bb4f2f206c8b990e0ba4825f75249b"),
		.binaryTarget(
			name:"PSON",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.0-rc3/pson-1.0.7.xcframework.zip",
			checksum: "c6c26ebde276681347fc26ecb3b612cc1df87db1daa9c6efcd97dd73ada9b3dc"),
		.binaryTarget(
			name:"OpenSSL",
			url:"https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.0-rc3/openssl-3.0.16.xcframework.zip",
			checksum: "61b81d46ad667ff37de468ab64b183723cd0807f99bcc8a3f2ec646afc14e8de"),
		.binaryTarget(
			name:"PrivMXEndpoint",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.0-rc3/privmx-endpoint-v2.6.0-rc1.xcframework.zip",
			checksum: "9cd79ec9e37213ace8bbdd5ab6dc19c4bf934f1551f0b5ddfec4c7f97576b8a2")

	],
	cxxLanguageStandard: .cxx17
)
