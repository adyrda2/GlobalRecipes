import SwiftUI
import Testing
@testable import GlobalRecipes

class CachedImageManagerTests {
    var mockCache: MockCache!
    var mockImageRetriever: MockImageRetriever!
    var mockLocalFileManager: MockLocalFileManager!
    var sut: CachedImageManager!

    init() {
        mockCache = MockCache()
        mockImageRetriever = MockImageRetriever()
        mockLocalFileManager = MockLocalFileManager()
        sut = CachedImageManager(imageRetriever: mockImageRetriever, localFileManager: mockLocalFileManager)
    }

    deinit {
        mockCache = nil
        mockImageRetriever = nil
        mockLocalFileManager = nil
        sut = nil
    }

    @Test("When an image doesn't exist in the cache or on disk, check if there is a file path for it and if so remove it, save it to the cache, and save it to the file manager.")
    func loadWithNoCachedImageAvailable() async {
        let _ = await sut.load((uuid: "123", imageURL: "test"), cache: mockCache)
        #expect(mockCache.objectForKeyWasCalled == true)
        #expect(mockCache.setObjectForKeyWasCalled == true)
        #expect(mockLocalFileManager.retrieveWasCalled == true)
        #expect(mockLocalFileManager.removeWasCalled == true)
        #expect(mockLocalFileManager.saveWasCalled == true)
    }

    @Test("When an image exists in memory (in NSCache) no other checks are needed.")
    func loadWhenImageExists() async {
        mockCache.imageDataInCache = await MockImage().drawRect()?.pngData() as? NSData
        let _ = await sut.load((uuid: "123", imageURL: "test"), cache: mockCache)
        #expect(mockCache.objectForKeyWasCalled == true)
        #expect(mockCache.setObjectForKeyWasCalled == false)
        #expect(mockLocalFileManager.retrieveWasCalled == false)
        #expect(mockLocalFileManager.removeWasCalled == false)
        #expect(mockLocalFileManager.saveWasCalled == false)
    }

    @Test("When an image does not exist in the cache, but exists on disk, and is within the expiration date, save it to the cache.")
    func loadImageFromDiskNotExpired() async {
        let _ = await sut.load((uuid: "1234", imageURL: "test"), cache: mockCache)
        #expect(mockCache.objectForKeyWasCalled == true)
        #expect(mockCache.setObjectForKeyWasCalled == true)
        #expect(mockLocalFileManager.retrieveWasCalled == true)
        #expect(mockLocalFileManager.removeWasCalled == false)
        #expect(mockLocalFileManager.saveWasCalled == false)
    }

    @Test("When an image does not exist in the cache, but exists on disk, and is exipired, re-save it to the filemanager, and save it to cache.")
    func loadImageDoesNotExistAndIsNotExpired() async {
        let _ = await sut.load((uuid: "5678", imageURL: "test"), cache: mockCache)
        #expect(mockCache.objectForKeyWasCalled == true)
        #expect(mockCache.setObjectForKeyWasCalled == true)
        #expect(mockLocalFileManager.retrieveWasCalled == true)
        #expect(mockLocalFileManager.removeWasCalled == true)
        #expect(mockLocalFileManager.saveWasCalled == true)
    }
}
