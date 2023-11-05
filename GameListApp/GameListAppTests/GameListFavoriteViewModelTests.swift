//
//  GameListFavoriteViewModelTests.swift
//  GameListAppTests
//
//  Created by Erdi Kanık on 5.11.2023.
//

import XCTest
@testable import GameListApp

final class GameListFavoriteViewModelTests: XCTestCase {

    var viewModel: GameListFavoriteViewModel!
    var mockDataSource: DataSource!

    class DataSource: GameListDataSourceInterface {
        var games: [Game] = []

        func addToFavorites(game: GameListApp.Game) {
            games.append(game)
        }
        
        func favorites() -> [GameListApp.Game] {
            games
        }
        
        func contains(gameId: Int) -> Bool {
            games.contains(where: { $0.gameId == gameId })
        }
        
        func remove(gameId: Int) {
            games.removeAll(where: { $0.gameId == gameId })
        }
    }

    override func setUpWithError() throws {

        mockDataSource = DataSource()
        viewModel = GameListFavoriteViewModel(dataSource: mockDataSource)

        viewModel.stateChangeHandler = { [weak self] state in
            switch(state) {
            case.favorites(let games):
                break
            }
        }
    }

}
