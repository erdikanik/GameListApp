//
//  AppDelegate.swift
//  GameListApp
//
//  Created by Erdi Kanık on 4.11.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var router: GameListRouter!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let storyboard = UIStoryboard(name: ViewConstants.StoryboardNames.gameBoard.rawValue, bundle: nil)

        guard let tabbarController = storyboard.instantiateViewController(
            withIdentifier: ViewConstants.TabbarControllers.gameListTabbarController.rawValue
        ) as? UITabBarController,
              let gameListViewController = tabbarController.viewControllers?.first as? GameListDashboardViewController else {
            return false
        }

        gameListViewController.gameListRouter = router
        window = UIWindow(frame: UIScreen.main.bounds)

        window?.rootViewController = tabbarController
        window?.makeKeyAndVisible()

        return true
    }
}

