import Foundation
import SwiftUI

protocol ImageRetrievable {
    func fetch(_ imageURL: String) async throws -> Data?
}

struct ImageRetriever: ImageRetrievable {
    func fetch(_ imageURL: String) async throws -> Data? {
        guard let url = URL(string: imageURL) else {
            throw ImageRetrievingError.invalidURL
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            throw ImageRetrievingError.invalidData
        }
    }
}

extension ImageRetriever {
    enum ImageRetrievingError: Error {
        case invalidURL
        case invalidData
    }
}
