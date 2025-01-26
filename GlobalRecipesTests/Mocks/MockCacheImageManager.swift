import SwiftUI
@testable import GlobalRecipes

class MockCachedImageManager: Loadable {
    var fetchedImageData: NSData? = nil
    var existingImageData: NSData?
    let mockCache: Cachable = MockCache()

    func load(_ recipeImage: (uuid: String, imageURL: String), cache: Cachable) async -> NSData? {

        let imageInCache = existingImageData

        if let existingImage = imageInCache {
            return existingImage
        }

        let fetchedImageData = fetchedImageData

        if let imageToCache = fetchedImageData  {
            mockCache.set(object: imageToCache, forKey: recipeImage.uuid as NSString)
        }

        return fetchedImageData
    }
}
