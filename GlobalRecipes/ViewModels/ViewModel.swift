import Foundation

class ViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    var networkManager: NetworkManager

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    func fetchRecipeData() async {
        do {
            recipes = try await networkManager.fetchRecipes()
        }
        catch {
//        TODO: HandleError
        }
    }
}
