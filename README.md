# YYStorage
 A property wrapper for UserDefaults that supports Codable types and SwiftUI.
 
## Installation

### Swift Package Manager

Add the following to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/YYStorage.git", from: "1.0.0")
]
```

## Usage

```swift
class UserSettings {
    @YYStorage(key: "username", defaultValue: "")
    var username: String
    
    @YYStorage(key: "isFirstLaunch", defaultValue: true)
    var isFirstLaunch: Bool
}
```

## Features

- Property wrapper for UserDefaults
- Supports Codable types
- SwiftUI compatible
- iOS 11.0+ support
