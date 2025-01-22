import Foundation

class NetworkManager {
    private var session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    func fetchRecipes() async throws -> [Recipe] {
        var urlBuilder = URLBuilder(baseURL: BaseURL.development.url, path: Endpoints.recipes.path)
        guard let url = urlBuilder.buildURL() else {
            throw RecipeError.invalidURL
        }
        let (data, response) = try await session.data(from: url)
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
