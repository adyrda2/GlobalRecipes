import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel(networkManager: NetworkManager())

    var body: some View {
        NavigationView {
            switch viewModel.status {
            case .idle:
                ProgressView()
            case .failure:
                MalformedRecipesErrorView()
            case .success:
                if viewModel.recipes.isEmpty {
                    RecipesEmptyState()
                } else {
                    List(viewModel.recipes, id: \.self) { recipe in
                        RecipeCell(recipe: recipe)
                            .listRowBackground(Color.clear)
                    }
                    .navigationTitle("Recipes")
                    .scrollContentBackground(.hidden)
                    .refreshable {
                        await viewModel.fetchRecipeData()
                    }
                }
            }
        }
        .task {
            await viewModel.fetchRecipeData()
        }
    }
}

#Preview {
    ContentView()
}
