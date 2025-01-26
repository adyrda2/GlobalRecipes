import SwiftUI

struct RecipeCell: View {
    let recipe: Recipe

    var body: some View {
        HStack {
            if let url = recipe.photoURLSmall {
                CachedImage(url: url, uuid: recipe.uuid)
            }
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
    RecipeCell(recipe: Recipe(uuid: "1234", cuisine: "Italian", name: "Pizza"))
}
