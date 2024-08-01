// swift-tools-version: 5.10
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
			swiftSettings: [.interoperabilityMode(.Cxx)]),
		.binaryTarget(
			name:"GMP",
			url: "https://builds.simplito.com/swift/main/gmp/6.2.1/gmp.xcframework.zip",
			checksum: "d749d8d8c7c100b84ee66fa20c4c647598e5d5800a7dc2095e4c7c072999ed61"),
		.binaryTarget(
			name:"POCO",
			url: "https://builds.simplito.com/swift/main/poco/1.10.1-all/poco.xcframework.zip",
			checksum: "8205e94228823c901c709515cd765420e08a259e8e1145679da7f51c367667c7"),
		.binaryTarget(
			name:"PSON",
			url: "https://builds.simplito.com/swift/main/pson/1.0.2/pson.xcframework.zip",
			checksum: "1f4d9abc00c195c0bf3259eac07133188c3f612dc40690ae5e88774e7a74b88e"),
		.binaryTarget(
			name:"OpenSSL",
			url:"https://builds.simplito.com/swift/main/openssl/3.0.13/openssl.xcframework.zip",
			checksum: "010393c93116599618f72b04a606f70402147947e04422ae00f4170c869f43c4"),
		.binaryTarget(
			name:"PrivMXEndpoint",
			url: "https://builds.simplito.com/swift/main/privmx-endpoint/1.6.1/privmx-endpoint.xcframework.zip",
			checksum: "b105f61fbc8b928316440475dccd090750322a02937f73707a52b5597b5d996d")
	],
	cxxLanguageStandard: .cxx17
)
