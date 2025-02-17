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
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.2.3/gmp-6.3.0.xcframework.zip",
			checksum: "f6b247f6bccd71d64037dd6dc7a1ec6d2394d132b0131450982ae7202ff28fa7"),
		.binaryTarget(
			name:"POCO",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.2.3/poco-1.13.2.xcframework.zip",
			checksum: "3381e7dc181a41eca1c5baacd61163c950cf98d5c1e50f65e2656d828385ce84"),
		.binaryTarget(
			name:"PSON",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.2.3/pson-1.0.7.xcframework.zip",
			checksum: "94d86a0af5473446e9a7817610d6733d66a699941a066430f3c014b8ec592268"),
		.binaryTarget(
			name:"OpenSSL",
			url:"https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.2.3/openssl-3.0.15.xcframework.zip",
			checksum: "fa8e43c0c105d462181c69f2c1b941a7fa343e7447db0778ab6db2fa44d0c37a"),
		.binaryTarget(
			name:"PrivMXEndpoint",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.2.3/privmx-endpoint-2.2.3.xcframework.zip",
			checksum: "df81197c9658b4135494159bf8ca781ca97c5aebcf88c6f260d5b3187baa0db0")

	],
	cxxLanguageStandard: .cxx17
)
