//
//  GameFavoriteCell.swift
//  GameListApp
//
//  Created by Erdi Kanık on 5.11.2023.
//

import Foundation
import UIKit

final class GameFavoriteCell: UITableViewCell {

    @IBOutlet weak var gameImageView: UIImageView!
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var genresLabel: UILabel!

    var name: String = "" {
        didSet {
            nameLabel.text = name
        }
    }

    var genresText: String = "" {
        didSet {
            genresLabel.text = genresText
        }
    }
}
