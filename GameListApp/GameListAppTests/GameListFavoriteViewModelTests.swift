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

        viewModel.stateChangeHandler = { state in
            switch(state) {
            case.favorites(let games):
                XCTAssertEqual(games.count, 3, "Products count should be 2")
                XCTAssertEqual(games.first?.name, "Name1", "Name should be Name1")
                XCTAssertEqual(games[1].name, "Name2", "Name should be Name2")
                XCTAssertEqual(games[2].name, "Name3", "Name should be Name3")
                break
            }
        }
    }

    func testFavorites() {
        let game1 = Game(gameId: 0, name: "Name1")
        let game2 = Game(gameId: 1, name: "Name2")
        let game3 = Game(gameId: 2, name: "Name3")

        mockDataSource.addToFavorites(game: game1)
        mockDataSource.addToFavorites(game: game2)
        mockDataSource.addToFavorites(game: game3)

        let _ = XCTWaiter.wait(for: [XCTestExpectation(description: "Wait to check change handler")], timeout: 0.1)
    }
}
