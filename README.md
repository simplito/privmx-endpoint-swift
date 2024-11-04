# PrivMX Endpoint Swift

This repository provides a Swift wrapper for the native C++ library used by PrivMX to handle end-to-end (e2e) encryption. PrivMX is a privacy-focused platform designed to offer secure collaboration solutions by integrating robust encryption across various data types and communication methods. This project enables seamless integration of PrivMX’s encryption functionalities in Swift applications, preserving the security and performance of the original C++ library while making its capabilities accessible in the Swift ecosystem.

## About PrivMX

[PrivMX](https://privmx.dev) allows developers to build end-to-end encrypted apps used for communication. The Platform works according to privacy-by-design mindset, so all of our solutions are based on Zero-Knowledge architecture. This project extends PrivMX’s commitment to security by making its encryption features accessible to developers using Swift.

## Key Features

- End-to-End Encryption: Ensures that data is encrypted at the source and can only be decrypted by the intended recipient.
- Native C++ Library Integration: Leverages the performance and security of C++ while making it accessible in Swift applications.
- Cross-Platform Compatibility: Designed to support PrivMX on multiple operating systems and environments.
- Simple API: Easy-to-use interface for Swift developers without compromising security.

## Modules

PrivMX Endpoint Swift is a streamlined wrapper library that introduces C++ error handling to Swift, tailored specifically for the PrivMX Platform.

The library is organized into two primary targets:

- **`PrivMXEndpointSwiftNative`**: This target manages exception handling on the C++ side of the library.
- **`PrivMXEndpointSwift`**: This target offers Swift-based exception handling, encompassing Swift classes and throwing methods.

This Package implements models, exception catching, and the following modules:

- `CryptoApi` - Cryptographic methods used to encrypt/decrypt and sign your data or generate keys to
  work with PrivMX Bridge.
- `Connection` - Methods for managing connection with PrivMX Bridge.
- `ThreadApi` - Methods for managing Threads and sending/reading messages.
- `StoreApi` - Methods for managing Stores and sending/reading files.
- `InboxApi` - Methods for managing Inboxes and entries.

## Dependency setup

To use this package, add it as a dependency in your Xcode project or in your `Package.swift` file.

### Xcode Integration

In Xcode, navigate to your Project Navigator, right-click, and select **Add Package Dependencies...**. Then, paste the following URL into the **Search or Enter Package URL** field:

```
https://github.com/simplito/privmx-endpoint-swift
```

### Swift Package Manager

To add it directly to a Swift package, include this line in the `dependencies` array in your `Package.swift` file:

```swift
.package(
    url: "https://github.com/simplito/privmx-endpoint-swift",
    .upToNextMajor(from: .init(2, 0, 0))
),
```

## Usage

For more details on PrivMX Platform, including setup guides and API reference, visit [PrivMX documentation](https://docs.privmx.dev).


## License information

**PrivMX Endpoint Swift**
Copyright © 2024 Simplito sp. z o.o.

This project is part of the PrivMX Platform (https://privmx.dev).
This software is Licensed under the MIT License.

PrivMX Endpoint and PrivMX Bridge are licensed under the PrivMX Free License.
See the License for the specific language governing permissions and limitations.
