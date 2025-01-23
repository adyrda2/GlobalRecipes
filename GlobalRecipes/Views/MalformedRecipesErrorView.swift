import SwiftUI

struct MalformedRecipesErrorView: View {
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.icloud")
                .font(.system(size: 64))
                .foregroundColor(.gray)
                .padding()
            Text("Sorry, we were unable to process your request.")
                .padding()
            Text("Please try again later.")
        }
        .padding()
    }
}

#Preview {
    MalformedRecipesErrorView()
}
