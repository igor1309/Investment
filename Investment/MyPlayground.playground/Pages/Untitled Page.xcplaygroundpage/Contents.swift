import Foundation

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
            
            DispatchQueue.main.async {  // в оригинале нет, вставлено как в https://www.swiftbysundell.com/basics/networking
             
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
        task.resume()
    }
    
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {
        let task = decodingTask(with: request, decodingType: T.self) { (json , error) in
            
            //MARK: change to main queue
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        completion(Result.failure(.invalidData))
                    }
                    return
                }
                if let value = decode(json) {
                    completion(.success(value))
                } else {
                    completion(.failure(.jsonParsingFailure))
                }
            }
        }
        task.resume()
    }
}
