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

    /// Request to increase page count
    func needNewPage()
}

final class GameListViewModel {
    
    enum State {

        case initialGamesFetched([Game])
        case error(String)
    }

    private let networkManager: NetworkManagerProtocol!
    var stateChangeHandler: ((State) -> Void)?

    private var currentPage = 1;
    private var isLastCallHasNext = false
    private var isLastCallProcessing = false
    private var fetchedGameModels: [Game] = []

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}

// MARK: GameListViewModelInterface

extension GameListViewModel: GameListViewModelInterface {

    func fetchInitialGames() {
        fetchGamesByPage()
    }

    func needNewPage() {
        if (isLastCallHasNext && !isLastCallProcessing) {
            currentPage += 1
            isLastCallProcessing = true
            fetchGamesByPage()
        }
    }
}

// MARK: Private methods

extension GameListViewModel {

    private func fetchGamesByPage() {
        let request = GameListRequest()
        request.page = currentPage
        networkManager.performRequest(request: request) { [weak self] (result: Result<GameListResponse>) in
            self?.isLastCallProcessing = false
            switch result {
            case .error(let error):
                self?.stateChangeHandler?(.error(error.localizedDescription))
            case .success(let response):
                if let next = response.next {
                    self?.isLastCallHasNext = !next.isEmpty
                }
                self?.fetchedGameModels.append(contentsOf: response.results ?? [])
                self?.stateChangeHandler?(.initialGamesFetched(self?.fetchedGameModels ?? []))
            }
        }
    }
}
