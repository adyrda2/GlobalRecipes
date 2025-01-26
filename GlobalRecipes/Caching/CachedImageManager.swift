import Foundation
import SwiftUI

protocol Loadable {
    func load(_ recipeImage: (uuid: String, imageURL: String), cache: Cachable) async -> NSData?
}

class CachedImageManager: Loadable {
    private let imageRetriever: ImageRetrievable
    private let localFileManager: FileStorage

    init(imageRetriever: ImageRetrievable = ImageRetriever(), localFileManager: FileStorage = LocalFileManager.shared) {
        self.imageRetriever = imageRetriever
        self.localFileManager = localFileManager
    }

    func load(_ recipeImage: (uuid: String, imageURL: String), cache: Cachable = ImageCache.shared) async -> NSData? {

        if let existingImage = cache.object(forKey: recipeImage.uuid as NSString) {
            return existingImage
        }

        if let existingImageOnDisk = localFileManager.retrieve(with: recipeImage.uuid),
           Date.now < existingImageOnDisk.evictionDate {
            cache.set(object: existingImageOnDisk.imageData as NSData, forKey: existingImageOnDisk.uuid as NSString)
            return existingImageOnDisk.imageData as NSData
        }

        localFileManager.remove(with: recipeImage.uuid)

        let fetchedImage = try? await imageRetriever.fetch(recipeImage.imageURL)

        if let imageToCache = fetchedImage {
            cache.set(object: imageToCache as NSData, forKey: recipeImage.uuid as NSString)

            if let sixHoursFromNow = Calendar.current.date(byAdding: .hour, value: 6, to: .now) {
                localFileManager.save(.init(uuid: recipeImage.uuid, imageData: imageToCache, evictionDate: sixHoursFromNow))
            }
        }

        return fetchedImage as NSData?
    }
}
