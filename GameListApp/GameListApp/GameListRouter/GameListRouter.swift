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
}

final class GameListRouter: GameListRoutable {

    private let tabbarController: UITabBarController

    init(tabbarController: UITabBarController) {
        self.tabbarController = tabbarController
    }

    func startRouting() {
        guard let gameListDashboardViewController = 
                tabbarController.viewControllers?.first as? GameListDashboardViewController else {
            return
        }

        gameListDashboardViewController.gameListRouter = self
        
        let viewModel = GameListViewModel()
        gameListDashboardViewController.gameListViewModel = viewModel
    }
}
