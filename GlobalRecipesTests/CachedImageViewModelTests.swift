import SwiftUI
import Testing
@testable import GlobalRecipes

class CachedImageViewModelTests {
    var sut: CachedImageViewModel!
    var mockCachedImageManager: MockCachedImageManager!

    init() {
        mockCachedImageManager = MockCachedImageManager()
        sut = CachedImageViewModel(cachedImageManager: mockCachedImageManager)
    }

    deinit {
        mockCachedImageManager = nil
        sut = nil
    }

    @Test func loadWhenImageIsAvailable() async throws {
        mockCachedImageManager.fetchedImageData = await MockImage().drawRect()?.pngData() as? NSData
        let _ = await sut.loading("1234", imageURL: "test")
        let image = await sut.image
        #expect(image != nil)
    }

    @Test func loadWhenImageIsNotAvailable() async throws {
        let _ = await sut.loading("1234", imageURL: "test")
        let image = await sut.image
        #expect(image == nil)
    }
}
