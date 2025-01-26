import SwiftUI
@testable import GlobalRecipes

class MockCache: Cachable {
    var objectForKeyWasCalled = false
    var setObjectForKeyWasCalled = false
    var imageDataInCache: NSData? = nil

    func object(forKey key: NSString) -> NSData? {
        objectForKeyWasCalled = true
        return imageDataInCache != nil ? imageDataInCache : nil
    }

    func set(object: NSData, forKey key: NSString) {
        setObjectForKeyWasCalled = true
    }
}
