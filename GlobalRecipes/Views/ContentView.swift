import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel(networkManager: NetworkManager())

    var body: some View {
        if viewModel.recipes.isEmpty {
            RecipesEmptyState()
        } else {
            NavigationView {
                List(viewModel.recipes) { recipe in
                    RecipeCell(recipe: recipe)
                        .listRowBackground(Color.clear)
                }
                .navigationTitle("Recipes")
            }
            .scrollContentBackground(.hidden)
            .task {
                await viewModel.fetchRecipeData()
            }
        }
    }
}

#Preview {
    ContentView()
}
