import Foundation

struct URLBuilder {
    private var baseURL: String
    private var path: String
    private var queryParams: [URLQueryItem]

    init(baseURL: String, path: String) {
        self.baseURL = baseURL
        self.path = path
        self.queryParams = []
    }

    mutating func buildURL() -> URL? {
        let components = URLComponents(string: baseURL + path)
        return components?.url
    }
}
