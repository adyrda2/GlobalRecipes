import Foundation

enum Endpoints {
    case recipes
    case empty

    var path: String {
        switch self {
        case .recipes: "/recipes.json"
        case .empty: "recipes-empty.json"
        }
    }
}
