import Foundation

enum BaseURL {
    case development

    var url: String {
        switch self {
        case .development:
            "https://d3jbb8n5wk0qxi.cloudfront.net"
        }
    }
}
