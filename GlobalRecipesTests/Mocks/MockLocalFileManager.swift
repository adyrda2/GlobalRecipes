@testable import GlobalRecipes
import Foundation

class MockLocalFileManager: FileStorage {
    var removeWasCalled = false
    var retrieveWasCalled = false
    var saveWasCalled = false

    let recipeImages: [LocalFileManager.RecipeImage] = [
        LocalFileManager.RecipeImage(
            uuid: "1234",
            imageData: (MockImage().drawRect()?.pngData())!,
            evictionDate: Date.now + 1),
        LocalFileManager.RecipeImage(
            uuid: "5678",
            imageData: (MockImage().drawRect()?.pngData())!,
            evictionDate: Date.now - 1)
    ]

    func remove(with uuid: String) {
        removeWasCalled = true
    }

    func retrieve(with uuid: String) -> LocalFileManager.RecipeImage? {
        retrieveWasCalled = true
        return recipeImages.first(where: {$0.uuid == uuid })
    }

    func save(_ recipeImage: LocalFileManager.RecipeImage) {
        saveWasCalled = true
    }
}
