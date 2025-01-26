import SwiftUI
@testable import GlobalRecipes

class MockImageRetriever: ImageRetrievable {
    func fetch(_ imageURL: String) async throws -> Data? {
        return await MockImage().drawRect()?.pngData()
    }
}
