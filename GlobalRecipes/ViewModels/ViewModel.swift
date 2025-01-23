import Foundation

enum Status {
    case idle
    case success
    case failure
}

class ViewModel: ObservableObject {
    @MainActor @Published var recipes: [Recipe] = []
    @MainActor @Published var status: Status = .idle
    var networkManager: NetworkManager

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    func fetchRecipeData() async {
        do {
            let recipes = try await networkManager.fetchRecipes()
            await MainActor.run {
                self.recipes = recipes
                status = .success
            }
        }
        catch RecipeError.invalidJSON {
            await MainActor.run {
                status = .failure
            }
        }
        catch {
            //TODO: Handle other types of errors
        }
    }
}
