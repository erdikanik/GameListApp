//
//  GameListResponse.swift
//  GameListApp
//
//  Created by Erdi Kanık on 4.11.2023.
//

import Foundation

final class GameListResponse: Decodable {

    var next: String?
    var results: [Game]?
}
