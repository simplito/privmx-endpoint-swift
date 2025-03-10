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
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.1-rc1/gmp-6.3.0.xcframework.zip",
			checksum: "ae73379e6977fa6932d33a700259da2aac3091647c6eadea6bf2f5a8e9b1c73c"),
		.binaryTarget(
			name:"POCO",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.1-rc1/poco-1.13.2.xcframework.zip",
			checksum: "71ba0efd4aed0780ce76bb50e27ccbacf9bab5c7cc73ecf2b258fd23384ade35"),
		.binaryTarget(
			name:"PSON",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.1-rc1/pson-1.0.7.xcframework.zip",
			checksum: "5457fa325ae65e4ed4f28ff70e8e3cfd6da3801843a3f5be016c1543a98f8b9a"),
		.binaryTarget(
			name:"OpenSSL",
			url:"https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.1-rc1/openssl-3.0.16.xcframework.zip",
			checksum: "547bef20f95e0b273577772323c7bca88e76b4a091a5610e809afe92a94d6030"),
		.binaryTarget(
			name:"PrivMXEndpoint",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.3.1-rc1/privmx-endpoint-2.3.1-rc1.xcframework.zip",
			checksum: "21f6686a764dcc6530f6c5715d49ac448240435c1eeb2276c274ecaa21ff3fd7")

	],
	cxxLanguageStandard: .cxx17
)
