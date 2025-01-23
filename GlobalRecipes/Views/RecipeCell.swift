import SwiftUI

struct RecipeCell: View {
    let recipe: Recipe

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: recipe.photoURLSmall ?? "")) { image in
                image.resizable(resizingMode: .stretch)
            } placeholder: {
                Color.gray
            }
            .frame(width: 100, height: 100)
            .clipShape(.rect(cornerRadius: 25))
            .padding(.trailing, 8)
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .padding(.bottom, 8)
                Text(recipe.cuisine)
                    .font(.footnote)
            }
        }
    }
}

#Preview {
    RecipeCell(recipe: Recipe(cuisine: "Italian", name: "Pizza"))
}
