//
//  GameListFavoriteViewModel.swift
//  GameListApp
//
//  Created by Erdi Kanık on 5.11.2023.
//

import Foundation

protocol GameListFavoriteViewModelInterface {

    /// State change handler
    var stateChangeHandler: ((GameListFavoriteViewModel.State) -> Void)? { get set }

    /// Favorite list
    func favoriteList()

    /// Remove from favorites
    /// - Parameter gameId: Game id
    func removeFromFavorites(gameId: Int)
}

final class GameListFavoriteViewModel {

    enum State {

        case favorites([Game])
        case removed(String)
    }

    var stateChangeHandler: ((State) -> Void)?

    private let dataSource: GameListDataSourceInterface

    init(dataSource: GameListDataSourceInterface) {
        self.dataSource = dataSource
    }
}

extension GameListFavoriteViewModel: GameListFavoriteViewModelInterface {

    func favoriteList() {
        let favorites = dataSource.favorites()
        stateChangeHandler?(.favorites(favorites))
    }

    func removeFromFavorites(gameId: Int) {
        dataSource.remove(gameId: gameId)
        stateChangeHandler?(.removed("\(gameId) is removed"))
    }
}
