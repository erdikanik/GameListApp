//
//  GameListDetailViewModel.swift
//  GameListApp
//
//  Created by Erdi Kanık on 5.11.2023.
//

import Foundation

protocol GameListDetailViewModelInterface {
    
    /// State change handler
    var stateChangeHandler: ((GameListDetailViewModel.State) -> Void)? { get set }

    /// Retrieves game details
    func retrieveGameDetails()

    /// Add to favroites the game object
    func addToFavorites()

    /// Removes from favorites the game object
    func removeFromFavorites()
}

final class GameListDetailViewModel {

    enum State {

        case gameDetailsFetched(Game, Bool)
        case error(String)
    }

    var stateChangeHandler: ((State) -> Void)?

    private let networkManager: NetworkManagerProtocol
    private let dataSource: GameListDataSource
    private let selectedGameId: Int

    private var fetchedGame: Game?

    init(selectedGameId: Int, networkManager: NetworkManagerProtocol, dataSource: GameListDataSource) {
        self.selectedGameId = selectedGameId
        self.networkManager = networkManager
        self.dataSource = dataSource
    }
}

// MARK: GameListDetailViewModelInterface

extension GameListDetailViewModel: GameListDetailViewModelInterface {

    func retrieveGameDetails() {
        let request = GameListDetailRequest()
        request.gameId = selectedGameId
        
        networkManager.performRequest(request: request) { [weak self] (result: Result<Game>) in
            switch result {
            case .error(let error):
                self?.stateChangeHandler?(.error(error.localizedDescription))
            case .success(let game):
                self?.fetchedGame = game
                let isExist = self?.dataSource.contains(gameId: game.gameId) ?? false
                self?.stateChangeHandler?(.gameDetailsFetched(game, isExist))
            }
        }
    }
    
    func addToFavorites() {
        if let game = fetchedGame {
            dataSource.addToFavorites(game: game)
        }
    }
    
    func removeFromFavorites() {
        dataSource.remove(gameId: selectedGameId)
    }
}
