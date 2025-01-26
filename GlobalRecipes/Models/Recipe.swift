import Foundation

struct Response: Codable {
    var recipes: [Recipe]
}

struct Recipe: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var cuisine: String
    var name: String
    var photoURLSmall: String?

    private enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photoURLSmall = "photo_url_small"
    }
}
