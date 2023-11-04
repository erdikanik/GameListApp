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
    }

    var page: Int = 1

    override var path: String {
        NetworkConfiguration.NetworkUrls.dashboard.getUrl()
    }

    override var parameters: [String : String] {
        var parameters = [
            Constant.page: String(page)
        ]
        super.parameters.forEach { parameters[$0] = $1 }
        return parameters
    }
}
