import Foundation
import SwiftUI

class CachedImageViewModel: ObservableObject {
    @MainActor @Published private(set) var image: UIImage?
    var cachedImageManager: Loadable

    init(cachedImageManager: Loadable = CachedImageManager()) {
        self.cachedImageManager = cachedImageManager
    }

    func loading(_ uuid: String, imageURL: String, cache: ImageCache = .shared) async {
        let imageData = await cachedImageManager.load((uuid: uuid, imageURL: imageURL), cache: cache)

        guard let data = imageData as? Data else {
            await MainActor.run {
                self.image = nil
            }
            return
        }

        await MainActor.run {
            self.image = UIImage(data: data)
        }
    }
}
