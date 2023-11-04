//
//  GameListViewModel.swift
//  GameListApp
//
//  Created by Erdi Kanık on 4.11.2023.
//

import Foundation

protocol GameListViewModelInterface {

    /// State change handler
    var stateChangeHandler: ((GameListViewModel.State) -> Void)? { get set }

    /// Request initial games
    func fetchInitialGames()
}

final class GameListViewModel {
    
    enum State {

        case initialGamesFetched([Game])
    }

    var stateChangeHandler: ((State) -> Void)?
}

// MARK: GameListViewModelInterface

extension GameListViewModel: GameListViewModelInterface {

    func fetchInitialGames() {
        // TODO: Will be implemented
    }
}
