import Foundation

enum Endpoints {
    case recipes
    case empty
    case malformed

    var path: String {
        switch self {
        case .recipes: "/recipes.json"
        case .empty: "/recipes-empty.json"
        case .malformed: "/recipes-malformed.json"
        }
    }
}
