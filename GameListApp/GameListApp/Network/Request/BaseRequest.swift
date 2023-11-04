//
//  BaseRequest.swift
//  GameListApp
//
//  Created by Erdi Kanık on 4.11.2023.
//

import Foundation

class BaseRequest {

    private enum MappingKeys {
        static let apiKey = "key"
    }

    var path: String {
        ""
    }

    var parameters: [String: String] {
        return [MappingKeys.apiKey: NetworkConfiguration.apiKey]
    }

    private func urlParameters() -> String {
        let urlMap = "?"
        return urlMap + parameters.map { $0.key + "=" + $0.value + "&" }.joined()
    }

    func asURLRequest() -> URLRequest? {
        guard let url = URL(string: path.appending(urlParameters())) else {
            return nil
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"

        return urlRequest
    }
}
