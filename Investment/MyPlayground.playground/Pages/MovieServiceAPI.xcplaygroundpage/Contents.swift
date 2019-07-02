//: [Previous](@previous)

import Foundation

private func fetchResources<T: Decodable>(url: URL, completion: @escaping (Result<T, APIServiceError>) -> Void) {
    guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
        completion(.failure(.invalidEndpoint))
        return
    }
    let queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
    urlComponents.queryItems = queryItems
    guard let url = urlComponents.url else {
        completion(.failure(.invalidEndpoint))
        return
    }
    
    urlSession.dataTask(with: url) { (result) in
        switch result {
        case .success(let (response, data)):
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            do {
                let values = try self.jsonDecoder.decode(T.self, from: data)
                completion(.success(values))
            } catch {
                completion(.failure(.decodeError))
            }
        case .failure(let error):
            completion(.failure(.apiError))
        }
        }.resume()
}
