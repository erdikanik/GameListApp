//
//  GameListFavoriteViewController.swift
//  GameListApp
//
//  Created by Erdi Kanık on 5.11.2023.
//

import Foundation
import UIKit

final class GameListFavoriteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noFavoritesLabel: UILabel!

    private var favorites: [Game] = []

    var viewModel: GameListFavoriteViewModelInterface?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("Favorites", comment: "")
        tableView.register(GameFavoriteCell.nib(), forCellReuseIdentifier: GameFavoriteCell.reuseIdentifier())
        tableView.estimatedRowHeight = 250
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self

        viewModel?.stateChangeHandler = { [weak self] state in
            DispatchQueue.main.async {
                switch state {
                case .favorites(let favorites):
                    DispatchQueue.main.async {
                        self?.tableView.isHidden = favorites.isEmpty
                        self?.noFavoritesLabel.isHidden = !favorites.isEmpty
                        self?.favorites = favorites
                        self?.tableView.reloadData()
                    }
                    break
                case .removed(let result):
                    break
                }
            }
        }
    }
}

extension GameListFavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GameFavoriteCell.reuseIdentifier(),
                                                 for: indexPath)

        if let cell = cell as? GameFavoriteCell {
            let game = favorites[indexPath.row]
            cell.name = game.name ?? ""
            cell.genresText = game.genres?.compactMap { $0.name }.joined(separator: " , ") ?? ""
            cell.gameImageView.load(url: game.imageUrl, imageName: game.imageUrl?.urlComponentsLastItem() ?? "")
        }

        return cell
    }
}
