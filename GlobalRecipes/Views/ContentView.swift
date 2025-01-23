import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel(networkManager: NetworkManager())

    var body: some View {
        NavigationView {
            if viewModel.status == .failure {
                MalformedRecipesErrorView()
            }
            else if viewModel.recipes.isEmpty && viewModel.status == .success {
                RecipesEmptyState()
            } else {
                List(viewModel.recipes) { recipe in
                    RecipeCell(recipe: recipe)
                        .listRowBackground(Color.clear)
                }
                .refreshable {
                    await viewModel.fetchRecipeData()
                }
                .navigationTitle("Recipes")
            }
        }
        .scrollContentBackground(.hidden)
        .task {
            await viewModel.fetchRecipeData()
        }
    }
}

#Preview {
    ContentView()
}
