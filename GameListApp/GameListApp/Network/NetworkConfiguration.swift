//
//  NetworkConfiguration.swift
//  GameListApp
//
//  Created by Erdi Kanık on 4.11.2023.
//

import Foundation

enum NetworkConfiguration {

    static let apiKey = "3be8af6ebf124ffe81d90f514e59856c"

    enum NetworkUrls {

        static let dashboard = "?page_size=10&page=1"

        func baseUrl() -> String {
            guard let baseUrl = Bundle.main.infoDictionary?["BASE_URL"] as? String else {
                return ""
            }

            return baseUrl
        }
    }
}
