import Foundation

protocol FileStorage {
    func remove(with uuid: String)
    func retrieve(with uuid: String) -> LocalFileManager.RecipeImage?
    func save(_ recipeImage: LocalFileManager.RecipeImage)
}

final class LocalFileManager: FileStorage {
    static let shared = LocalFileManager()
    private let fileManager = FileManager.default
    private var cacheDirectoryURL: URL? {
        fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first
    }

    private init() {}

    func remove(with uuid: String) {
        if let cacheFile = cacheDirectoryURL?.appendingPathComponent(uuid + ".cache"),
           fileManager.fileExists(atPath: cacheFile.path) {
            do {
                try fileManager.removeItem(at: cacheFile)
            } catch {
                print("error removing")
            }
        }
    }

    func retrieve(with uuid: String) -> RecipeImage? {
        guard let cacheFolder = cacheDirectoryURL else { return nil }
        let fileURL = cacheFolder.appendingPathComponent(uuid + ".cache")
        guard let data = try? Data(contentsOf: fileURL),
              let recipe = try? JSONDecoder().decode(RecipeImage.self, from: data) else { return nil }
        return recipe
    }

    func save(_ recipeImage: RecipeImage) {
        guard let cacheFolder = cacheDirectoryURL
        else { return }

        let fileURL = cacheFolder.appendingPathComponent(recipeImage.uuid + ".cache")

        do {
            let data = try JSONEncoder().encode(recipeImage)
            try data.write(to: fileURL)
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension LocalFileManager {
    struct RecipeImage: Codable {
        let uuid: String
        let imageData: Data
        let evictionDate: Date
    }
}
