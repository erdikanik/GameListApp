//
//  GameGridCell.swift
//  GameListApp
//
//  Created by Erdi Kanık on 4.11.2023.
//

import Foundation
import UIKit

final class GameGridCell: UICollectionViewCell {

    @IBOutlet weak var gameImageView: UIImageView!
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var genresLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!

    var name = "" {
        didSet {
            nameLabel.text = name
        }
    }

    var genres = "" {
        didSet {
            genresLabel.text = genres
        }
    }

    var rating = 0 {
        didSet {
            ratingLabel.text = "Metacritic score: " + "\(rating)"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        applyDesign()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        gameImageView.image = nil
    }
}

// MARK: Design
private extension GameGridCell {

    func applyDesign() {
        self.layer.borderColor = UIColor.cyan.cgColor
        self.layer.borderWidth = 2
    }
}
