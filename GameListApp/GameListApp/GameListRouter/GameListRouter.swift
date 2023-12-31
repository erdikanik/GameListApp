//
//  GameListRouter.swift
//  GameListApp
//
//  Created by Erdi Kanık on 4.11.2023.
//

import Foundation
import UIKit

/// Interface that manages router's movements
protocol GameListRoutable: AnyObject { 

    /// Initializes routing
    func startRouting()

    /// Routes to detail
    /// - Parameter game: Game id to show details
    func routeToDetail(gameId: Int)
}

final class GameListRouter: GameListRoutable {

    private let tabbarController: UITabBarController
    private let networkManager = NetworkManager()
    private let dataSource = GameListDataSource()

    init(tabbarController: UITabBarController) {
        self.tabbarController = tabbarController
    }

    func startRouting() {
        guard let navigationController = tabbarController.viewControllers?.first as? UINavigationController,
              let gameListDashboardViewController = 
                navigationController.topViewController as? GameListDashboardViewController else {

            return
        }
        gameListDashboardViewController.gameListRouter = self
        
        let viewModel = GameListViewModel(networkManager: networkManager)
        gameListDashboardViewController.gameListViewModel = viewModel

        guard let navigationController = tabbarController.viewControllers?[1] as? UINavigationController,
              let gameListFavoriteViewController =
                navigationController.topViewController as? GameListFavoriteViewController else {

            return
        }

        let gameListFavoriteViewModel = GameListFavoriteViewModel(dataSource: dataSource)
        gameListFavoriteViewController.viewModel = gameListFavoriteViewModel
    }

    func routeToDetail(gameId: Int) {
        let storyboard = UIStoryboard(name: ViewConstants.StoryboardNames.gameBoard.rawValue, bundle: nil)
        guard let gameListDetailViewController = storyboard.instantiateViewController(
            withIdentifier: ViewConstants.ViewControllers.gameListDetailViewController.rawValue) as? GameListDetailViewController else { return }

        let gameListDetailViewModel = GameListDetailViewModel(
            selectedGameId: gameId,
            networkManager: networkManager,
            dataSource: dataSource)

        gameListDetailViewController.router = self
        gameListDetailViewController.viewModel = gameListDetailViewModel

        (tabbarController.viewControllers?.first
         as? UINavigationController)?.pushViewController(
            gameListDetailViewController, animated: true
         )
    }
}
