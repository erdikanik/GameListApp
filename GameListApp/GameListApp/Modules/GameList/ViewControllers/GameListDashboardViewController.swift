//
//  GameListDashboardViewController.swift
//  GameListApp
//
//  Created by Erdi Kanık on 4.11.2023.
//

import Foundation
import UIKit

final class GameListDashboardViewController: UIViewController {

    /// Manage route operations
    weak var gameListRouter: GameListRoutable?

    /// Manage logic operations
    var gameListViewModel: GameListViewModel?

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var games: [Game] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        gameListViewModel?.stateChangeHandler = { [weak self] state in

            switch state {
            case .initialGamesFetched(let games):
                self?.games = games
            case .error(_):
                // TODO: Will be implemented
                break
            }
        }

        gameListViewModel?.fetchInitialGames()
    }
}
