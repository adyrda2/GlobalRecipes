import SwiftUI

struct CachedImage: View {
    @StateObject private var cachedImageViewModel = CachedImageViewModel()
    let url: String
    let uuid: String

    var body: some View {
        ZStack {
            if let uiImage = cachedImageViewModel.image {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .clipped()
            }
        }
        .task {
            await cachedImageViewModel.loading(uuid, imageURL: url)
        }
    }
}

#Preview {
    CachedImage(url: "", uuid: "123")
}
