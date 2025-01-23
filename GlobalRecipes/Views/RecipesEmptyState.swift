import SwiftUI

struct RecipesEmptyState: View {
    var body: some View {
        VStack {
            Image(systemName: "fork.knife.circle")
                .font(.system(size: 64))
                .foregroundColor(.gray)
                .padding()
            Text("No Recipes")
                .font(.title2)
                .fontWeight(.bold)
            Text("There are no recipes available at this time. Try again later.")
                .font(.title3)
                .foregroundColor(Color.gray)
                .padding()
        }
        .padding()
    }
}

#Preview {
    RecipesEmptyState()
}
