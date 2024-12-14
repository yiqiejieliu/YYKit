// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

@propertyWrapper
public struct YYStorage<T: Codable> {
    
    private struct Wrapper: Codable {
        let wrapped: T
    }
    
    private let key: String
    private let defaultValue: T
    private let userDefaults: UserDefaults
    
    public init(key: String, defaultValue: T, userDefaults: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.userDefaults = userDefaults
    }
    
    public var wrappedValue: T {
        get {
            guard let data = userDefaults.object(forKey: key) as? Data else {
                return defaultValue
            }
            
            if #available(iOS 13, *) {
                let value = try? JSONDecoder().decode(T.self, from: data)
                return value ?? defaultValue
            } else {
                let value = try? JSONDecoder().decode(Wrapper.self, from: data)
                return value?.wrapped ?? defaultValue
            }
        }
        nonmutating set {
            if #available(iOS 13, *) {
                let data = try? JSONEncoder().encode(newValue)
                userDefaults.set(data, forKey: key)
            } else {
                let data = try? JSONEncoder().encode(Wrapper(wrapped: newValue))
                userDefaults.set(data, forKey: key)
            }
            userDefaults.synchronize()
        }
    }
}

#if canImport(SwiftUI)
import SwiftUI

extension YYStorage: DynamicProperty {
    public var projectedValue: YYStorage<T> {
        self
    }
    
    public mutating func update() { }
}
#endif
