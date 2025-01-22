import Foundation

class ViewModel: ObservableObject {
    @MainActor @Published var recipes: [Recipe] = []
    var networkManager: NetworkManager

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    func fetchRecipeData() async {
        do {
            let recipes = try await networkManager.fetchRecipes()
            await MainActor.run {
                self.recipes = recipes
            }
        }
        catch {
            //TODO: handle error
        }
    }
}
