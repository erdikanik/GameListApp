//
//  NetworkManager.swift
//  GameListApp
//
//  Created by Erdi Kanık on 4.11.2023.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(Error)
}

protocol NetworkManagerProtocol {

    @discardableResult
    func performRequest<T: Decodable>(request: BaseRequest, completion: @escaping (Result<T>) -> Void) -> URLSessionTask?
}

final class NetworkManager: NetworkManagerProtocol {

    func performRequest<T: Decodable>(request: BaseRequest, completion: @escaping (Result<T>) -> Void) -> URLSessionTask? {
        guard let networkRequest = request.asURLRequest() else { return nil }

        let task = URLSession.shared.dataTask(with: networkRequest) { (data, _, error) in
            guard let data = data else {
                completion(Result.error(error ?? NSError()))
                return
            }

            let decoder = JSONDecoder()

            do {
                let responseModel = try decoder.decode(T.self, from: data)
                completion(Result.success(responseModel))
            } catch {
                completion(Result.error(error))
            }
        }

        task.resume()
        return task
    }
}
