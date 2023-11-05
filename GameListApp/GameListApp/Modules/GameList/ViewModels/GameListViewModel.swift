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

    /// Search by key
    /// - Parameter parameterKey: Search keyword
    func searchGame(parameterKey: String)
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
    private var requestedSearchArray: [String] = []
    private var timer: Timer?
    private var currentUrlSessionTask: URLSessionTask?
    private var lastSearchKey: String?
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}

// MARK: GameListViewModelInterface

extension GameListViewModel: GameListViewModelInterface {

    func fetchInitialGames() {
        currentPage = 1
        fetchedGameModels.removeAll()
        lastSearchKey = nil
        fetchGamesByPage(searchKey: nil)
    }

    func needNewPage() {
        if (isLastCallHasNext && !isLastCallProcessing) {
            currentPage += 1
            isLastCallProcessing = true
            fetchGamesByPage(searchKey: lastSearchKey)
        }
    }

    func searchGame(parameterKey: String) {
        searchGames(searchKey: parameterKey)
    }
}

// MARK: Private methods

private extension GameListViewModel {

    func fetchGamesByPage(searchKey: String?) {
        let request = GameListRequest()
        request.page = currentPage
        request.searchKey = searchKey
        currentUrlSessionTask = networkManager.performRequest(request: request) { [weak self] (result: Result<GameListResponse>) in
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

    func searchGames(searchKey: String) {
        guard !searchKey.isEmpty else { return }
        requestedSearchArray.append(searchKey)

        if self.timer == nil {
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] timer in
                guard !(self?.requestedSearchArray.isEmpty ?? false) else {
                    self?.timer?.invalidate()
                    self?.timer = nil
                    return
                }

                self?.currentUrlSessionTask?.cancel()
                if let lastKey = self?.requestedSearchArray.last {
                    self?.fetchedGameModels.removeAll()
                    self?.currentPage = 1
                    self?.lastSearchKey = lastKey
                    self?.fetchGamesByPage(searchKey: lastKey)
                }
                self?.requestedSearchArray.removeAll()
            }
        }
    }
}
