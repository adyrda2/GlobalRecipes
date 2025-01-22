import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel(networkManager: NetworkManager())

    var body: some View {
        NavigationView {
            List(viewModel.recipes) { recipe in
                Text(recipe.name)
                Text(recipe.cuisine)
                AsyncImage(url: URL(string: recipe.photoURLSmall ?? "")) { image in
                    image.resizable(resizingMode: .stretch)
                } placeholder: {
                    Color.gray
                }
                .frame(width: 256, height: 256)
                .clipShape(.rect(cornerRadius: 25))
            }
            .navigationTitle("Recipes")
        }
        .padding()
        .task {
            await viewModel.fetchRecipeData()
        }
    }
}

#Preview {
    ContentView()
}
