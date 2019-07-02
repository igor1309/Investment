import Foundation


//  https://forums.swift.org/t/passing-decodable-object-type-as-generic-parameter/13870/4
//func decode<T>(modelType: T.Type) where T : Decodable {
//    let myStruct = try! JSONDecoder().decode(modelType, from: data!)
//    ...
//}




struct CapEx {
    var id = UUID()
    var name: String
    var description: String
    var lifetime: Int           // in years
    var isDepreciable: Bool     // non Depreciable assets are expences forming Working Capital
    var value: Int
}

enum NetworkError: Error {
    case badURL
    case notFound   //  404
    
    var localizedDescription: String {
        switch self {
        case .badURL: return "invalid URL"
        case .notFound: return "File not found"
        }
    }
}

enum APIError: Error {  //https://medium.com/@jamesrochabrun/protocol-based-generic-networking-using-jsondecoder-and-decodable-in-swift-4-fc9e889e8081
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure

    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        }
    }
}

protocol APIClient {    //  https://medium.com/@jamesrochabrun/protocol-based-generic-networking-using-jsondecoder-and-decodable-in-swift-4-fc9e889e8081
    var session: URLSession { get }
    
    func fetch<T: Decodable>(with request: URLRequest,
                             decode: @escaping (Decodable) -> T?,
                             completion: @escaping (Result<T, APIError>) -> Void)
}

extension APIClient {    //  https://medium.com/@jamesrochabrun/protocol-based-generic-networking-using-jsondecoder-and-decodable-in-swift-4-fc9e889e8081
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    
    private func decodingTask<T: Decodable>(with request: URLRequest,
                                            decodingType: T.Type,
                                            completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let genericModel = try JSONDecoder().decode(decodingType, from: data)
                        completion(genericModel, nil)
                    } catch {
                        completion(nil, .jsonConversionFailure)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
        }
        return task
    }
}




extension URLSession {  //  https://medium.com/@alfianlosari/building-simple-async-api-request-with-swift-5-result-type-alfian-losari-e92f4e9ab412
    func dataTask(with url: URL, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
}
