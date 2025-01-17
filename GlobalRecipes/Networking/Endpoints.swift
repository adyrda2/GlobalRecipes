import Foundation

enum Endpoints {
    case recipes

    var path: String {
        switch self {
        case .recipes: "/recipes.json"
        }
    }
}
