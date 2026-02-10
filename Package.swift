// swift-tools-version: 6.1
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
		.library(
			name: "PrivMXEndpointSwiftWithStreams",
			targets: [
				"PrivMXEndpointSwift",
				"PrivMXEndpointSwiftNative",
				"PrivMXEndpoint",
				"WebRTC",
				"POCO",
				"PSON",
				"GMP",
				"OpenSSL",])
	],
	traits:[
		"Streams",
		.default(enabledTraits: ["Streams"])
	],
	targets: [
		.target(
			name: "PrivMXEndpointSwiftNative",
			dependencies: ["GMP","POCO","PSON","PrivMXEndpoint","OpenSSL"],
			cxxSettings: [.headerSearchPath("include")],
			swiftSettings: [.interoperabilityMode(.Cxx)],
		),
		.target(
			name: "PrivMXEndpointSwift",
			dependencies: [
				"PrivMXEndpointSwiftNative",
				.target(
					name: "WebRTC",
						//condition: .when(traits: ["Streams"])
					   )
			],
			swiftSettings: [
				.interoperabilityMode(.Cxx),
			]),
		.binaryTarget(
			name:"WebRTC",
			path: "../Frameworks/WebRTC.xcframework"),
		.binaryTarget(
			name:"GMP",
			//url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.4/gmp-6.3.0.xcframework.zip",
			//checksum: "cd85dca1160f45c6e364f090bcd8b3b5a5dbb05eb39cf851accc567566e49b3a"),
			path: "../Frameworks/gmp.xcframework"),
		.binaryTarget(
			name:"POCO",
			//url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.4/poco-1.13.2.xcframework.zip",
			//checksum: "9147a5e4d78a1763ca51e730b8afc9c930d7f216832a43cb2d9589b0d76fd7f4"),
			path: "../Frameworks/poco.xcframework"),
		.binaryTarget(
			name:"PSON",
			//url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.4/pson-1.0.7.xcframework.zip",
			//checksum: "c8dad9a893632023439d8e287a40a2d8e618234b83034772ea219dcfb48508a9"),
			path: "../Frameworks/pson.xcframework"),
		.binaryTarget(
			name:"OpenSSL",
			//url:"https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.4/openssl-3.0.18.xcframework.zip",
			//checksum: "3869a3a0ece9cecbd41e1d8cf3a23b37b90c16abbe4fcb0addef67bbd74eaa75"),
			path: "../Frameworks/openssl.xcframework"),
		.binaryTarget(
			name:"PrivMXEndpoint",
			//url: "https://github.com/simplito/privmx-endpoint-xcframeworks/releases/download/2.6.4/privmx-endpoint-v2.6.4.xcframework.zip",
			//checksum: "9579bd10baffe2c981de8ad3a04e2f07b10f8333ee5c1e4aa4112f0a120bfd9b")
			path: "../Frameworks/privmx-endpoint.xcframework"),

	],
	cxxLanguageStandard: .cxx17
)

