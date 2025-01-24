import Foundation
@testable import GlobalRecipes

class MockNetworkManager: NetworkManagerProtocol {
    var values: (Data, URLResponse)? = nil

    func fetchRecipes() async throws -> [Recipe] {
        let (data, response) = values!
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw RecipeError.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(Response.self, from: data)
            return response.recipes
        } catch {
            throw RecipeError.invalidJSON
        }
    }
}
