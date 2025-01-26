import Foundation
import SwiftUI

protocol Cachable {
    func object(forKey key: NSString) -> NSData?
    func set(object: NSData, forKey key: NSString)
}

class ImageCache: Cachable {
    static let shared = ImageCache()

    private init() {}

    private lazy var cache: NSCache<NSString, NSData> = {
        let cache = NSCache<NSString, NSData>()
        cache.countLimit = 100
        cache.totalCostLimit = 100 * 1024 * 1024
        return cache
    }()

    func object(forKey key: NSString) -> NSData? {
        return cache.object(forKey: key)
    }

    func set(object: NSData, forKey key: NSString) {
        cache.setObject(object, forKey: key)
    }
}
