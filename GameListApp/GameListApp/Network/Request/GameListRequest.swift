//
//  GameListRequest.swift
//  GameListApp
//
//  Created by Erdi Kanık on 4.11.2023.
//

import Foundation

final class GameListRequest: BaseRequest {

    private enum Constant {

        static let page = "page"
        static let searchKey = "search"
    }

    var page = 1
    var searchKey: String?

    override var path: String {
        NetworkConfiguration.NetworkUrls.dashboard.getUrl()
    }

    override var parameters: [String : String] {
        var parameters = [
            Constant.page: String(page)
        ]

        if let searchKey = searchKey {
            parameters[Constant.searchKey] = searchKey
        }
        super.parameters.forEach { parameters[$0] = $1 }
        return parameters
    }
}
