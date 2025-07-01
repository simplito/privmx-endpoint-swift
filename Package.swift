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
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.5.3/gmp-6.3.0.xcframework.zip",
			checksum: "d699c72eae675bd1b78cd903236b7d6724b22f7213ba91b0451683f430ac0ac6"),
		.binaryTarget(
			name:"POCO",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.5.3/poco-1.13.2.xcframework.zip",
			checksum: "23956ca9ae72585d2158d0f9836b5b71184f6ebfb392a7af34d3fff704a4189d"),
		.binaryTarget(
			name:"PSON",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.5.3/pson-1.0.7.xcframework.zip",
			checksum: "e7a8773f43b9792c42f93d4aae53b4a942e39a149b71dac4099950dfa6f125a7"),
		.binaryTarget(
			name:"OpenSSL",
			url:"https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.5.3/openssl-3.0.16.xcframework.zip",
			checksum: "b628a920217e792365231a48323e19de75cabaee84b81cfd378d5c1c16ff7855"),
		.binaryTarget(
			name:"PrivMXEndpoint",
			url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.5.3/privmx-endpoint-v2.5.3.xcframework.zip",
			checksum: "3da66cc8668f9132a656ae4d252d5795e8340d0b4ef1ae6ae761950a2dd18c84")

	],
	cxxLanguageStandard: .cxx17
)
