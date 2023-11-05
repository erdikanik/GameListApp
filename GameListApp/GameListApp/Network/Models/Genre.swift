//
//  Genre.swift
//  GameListApp
//
//  Created by Erdi Kanık on 4.11.2023.
//

import Foundation

struct Genre: Codable {

    private enum CodingKeys: String, CodingKey {

        case genreId = "id"
        case name
    }

    let genreId: Int
    var name: String?
}
