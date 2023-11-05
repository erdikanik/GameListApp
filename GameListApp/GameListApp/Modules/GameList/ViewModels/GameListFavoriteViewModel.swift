//
//  GameListFavoriteViewModel.swift
//  GameListApp
//
//  Created by Erdi Kanık on 5.11.2023.
//

import Foundation

protocol GameListFavoriteViewModelInterface {

    func favoriteList() -> [Game]
    func removeFromFavorites(gameId: Int)
}

final class GameListFavoriteViewModel {

    private let dataSource: GameListDataSourceInterface

    init(dataSource: GameListDataSourceInterface) {
        self.dataSource = dataSource
    }
}

extension GameListFavoriteViewModel: GameListFavoriteViewModelInterface {

    func favoriteList() -> [Game] {

        return dataSource.favorites()
    }

    func removeFromFavorites(gameId: Int) {
        dataSource.remove(gameId: gameId)
    }
}
