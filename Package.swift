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
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.0-rc3/gmp-6.3.0.xcframework.zip",
			checksum: "ee1673bffbdf39bb53fd5a182beae7768dbce892cd361729a25e102c33c0cb63"),
		.binaryTarget(
			name:"POCO",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.0-rc3/poco-1.13.2.xcframework.zip",
			checksum: "35a90c814956120ab4adebae31f4f9ad071a3acbc397542a2b6172b756dc42b8"),
		.binaryTarget(
			name:"PSON",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.0-rc3/pson-1.0.7.xcframework.zip",
			checksum: "76651ccd84af30965a4259d64375342aea8259bf4620b7730e0ccd6f8806be01"),
		.binaryTarget(
			name:"OpenSSL",
			url:"https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.0-rc3/openssl-3.0.16.xcframework.zip",
			checksum: "9bab67e525881dac35c31dcff8640ee9f6029e9f89db1e278c840860f59928f6"),
		.binaryTarget(
			name:"PrivMXEndpoint",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.0-rc3/privmx-endpoint-2.3.0-rc3.xcframework.zip",
			checksum: "ab35407d71bcc4fb88390da2907ebad428f012f690564c1f1c68177aa50d0996")

	],
	cxxLanguageStandard: .cxx17
)
