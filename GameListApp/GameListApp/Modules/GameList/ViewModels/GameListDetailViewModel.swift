//
//  GameListDetailViewModel.swift
//  GameListApp
//
//  Created by Erdi Kanık on 5.11.2023.
//

import Foundation

protocol GameListDetailViewModelInterface {
    
    /// State change handler
    var stateChangeHandler: ((GameListViewModel.State) -> Void)? { get set }

    /// Retrieves game details
    func retrieveGameDetails()

    /// Add to favroites the game object
    func addToFavorites()

    /// Removes from favorites the game object
    func removeFromFavorites()
}

final class GameListDetailViewModel {

    enum State {

        case gameDetailsFetched(Game)
        case error(String)
    }

    private let networkManager: NetworkManagerProtocol
    private let dataSource: GameListDataSource
    private let selectedGame: Game

    init(selectedGame: Game, networkManager: NetworkManagerProtocol, dataSource: GameListDataSource) {
        self.selectedGame = selectedGame
        self.networkManager = networkManager
        self.dataSource = dataSource
    }
}

// MARK: GameListDetailViewModelInterface

extension GameListViewModel: GameListDetailViewModelInterface {

    func retrieveGameDetails() {
        // TODO: Will be implemented
    }
    
    func addToFavorites() {
        // TODO: Will be implemented
    }
    
    func removeFromFavorites() {
        // TODO: Will be implemented
    }
}
