//
//  GameListTabbarController.swift
//  GameListApp
//
//  Created by Erdi Kanık on 4.11.2023.
//

import Foundation
import UIKit

final class GameListTabbarController: UITabBarController {

    enum Constant {

        static let tabbarItem1Title = "Game List"
        static let tabbarItem2Title = "Favorites"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyTabbarDesign()
    }
}

// MARK: Views

extension GameListTabbarController {

    func applyTabbarDesign() {
        if let tabBarItem1 = tabBar.items?[0] {
            tabBarItem1.title = Constant.tabbarItem1Title
            tabBarItem1.image = UIImage(systemName: "gamecontroller.fill")
            tabBarItem1.selectedImage = UIImage(systemName: "gamecontroller.square")
         }
         if let tabBarItem2 = tabBar.items?[1] {
            tabBarItem2.title = Constant.tabbarItem2Title
            tabBarItem2.image = UIImage(systemName: "star.square.fill")
            tabBarItem2.selectedImage = UIImage(systemName: "star.square")
         }
    }
}
