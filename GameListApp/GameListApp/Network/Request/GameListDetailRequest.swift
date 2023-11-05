//
//  GameListDetailRequest.swift
//  GameListApp
//
//  Created by Erdi Kanık on 5.11.2023.
//

import Foundation

final class GameListDetailRequest: BaseRequest {

    var gameId = 0

    override var path: String {
        NetworkConfiguration.NetworkUrls.detail.getUrl() + "/" + "\(gameId)"
    }
}
