//
//  GameListRouter.swift
//  GameListApp
//
//  Created by Erdi Kanık on 4.11.2023.
//

import Foundation
import UIKit

/// Interface that manages router's movements
protocol GameListRoutable: AnyObject { }

final class GameListRouter: GameListRoutable {

    private var tabbarController: UITabBarController!
}
