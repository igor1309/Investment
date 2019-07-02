import Foundation

class MovieServiceAPI {
    
    public static let shared = MovieServiceAPI()
    private init() {}
    private let urlSession = URLSession.shared
    private let baseURL = URL(string: "https://api.themoviedb.org/3")!
    private let apiKey = "PUT_API KEY HERE"
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    // Enum Endpoint
    enum Endpoint: String, /*CustomStringConvertible,*/ CaseIterable {
        case nowPlaying = "now_playing"
        case upcoming
        case popular
        case topRated = "top_rated"
    }

    public enum APIServiceError: Error {
        case apiError
        case invalidEndpoint
        case invalidResponse
        case noData
        case decodeError
    }
}
