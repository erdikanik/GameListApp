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

        case dashboard
        case search
        case detail

        func getUrl() -> String {
            guard let baseUrl = Bundle.main.infoDictionary?["BASE_URL"] as? String else {
                return ""
            }

            switch self {
            case .dashboard, .search:
                return baseUrl + "?page_size=10&"
            case .detail:
                return baseUrl
            }
        }
    }
}
