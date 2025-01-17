import Foundation

struct Response: Codable {
    var recipes: [Recipe]
}

struct Recipe: Identifiable, Codable {
    var id: UUID = UUID()
    var cuisine: String?
    var name: String?

    private enum CodingKeys: String, CodingKey {
        case cuisine
        case name
    }
}
