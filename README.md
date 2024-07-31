# PrivMX Endpoint Swift 

PrivMX Endpoint Swift is a minimal wrapper library bringing C++ error handling to Swift for our PrivMX Platform.

This library consists of two Targets:
 - `PrivMXEndpointSwiftNative`, which provides exception handling of C++ library.
 - `PrivMXEndpointSwift`, which provides Swift side of exception handling (Swift classes and throwing methods).  
—————————————————

## Installation
To use this package simply add it add it as a Dependency in your Xcode project or in your `Package.swift` file.

You can do so by selecting `Add Package Dependencies...` in Project navigator context menu then pasting `https://github.com/simplito/privmx-endpoint-swift` in `Search or Enter Package URL` field.

When you want to add it to a Swift Package of yours, add
```swift
	.package(
		url:"https://github.com/simplito/privmx-endpoint-swift",
		.upToNextMajor(from: .init(1, 6, 0))
	),
```
To `dependencies` array in `Package.swift`.  
—————————————————

## Usage

For information about PrivMX Platform and documentation, go [HERE](https://docs.privmx.cloud).  
—————————————————

### Copyright © 2024 Simplito sp. z o.o.
### This software is Licensed under the MIT License.

### See the License for the specific language governing permissions and limitations under the License.
