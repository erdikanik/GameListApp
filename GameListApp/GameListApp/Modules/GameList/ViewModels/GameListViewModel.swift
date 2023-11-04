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
        case error(String)
    }

    private let networkManager: NetworkManagerProtocol!
    var stateChangeHandler: ((State) -> Void)?

    private let currentPage = 1;

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}

// MARK: GameListViewModelInterface

extension GameListViewModel: GameListViewModelInterface {

    func fetchInitialGames() {
        let request = GameListRequest()
        request.page = currentPage
        networkManager.performRequest(request: request) { [weak self] (result: Result<GameListResponse>) in
            switch result {
            case .error(let error):
                self?.stateChangeHandler?(.error(error.localizedDescription))
            case .success(let response):
                self?.stateChangeHandler?(.initialGamesFetched(response.results ?? []))
            }
        }
    }
}
