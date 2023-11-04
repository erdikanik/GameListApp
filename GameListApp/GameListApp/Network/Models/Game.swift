//
//  Game.swift
//  GameListApp
//
//  Created by Erdi Kanık on 4.11.2023.
//

import Foundation

struct Game: Decodable {

    private enum CodingKeys: String, CodingKey {

        case gameId = "id"
        case name
        case imageUrl = "background_image"
        case genres, metacritic
    }

    var gameId: Int
    var name: String?
    var imageUrl: String?
    var genres: [Genre]?
    var metacritic: Int
}
