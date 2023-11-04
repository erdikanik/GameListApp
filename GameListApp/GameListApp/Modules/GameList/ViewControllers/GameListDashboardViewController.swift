//
//  GameListDashboardViewController.swift
//  GameListApp
//
//  Created by Erdi Kanık on 4.11.2023.
//

import Foundation
import UIKit

final class GameListDashboardViewController: UIViewController {

    /// Manage route operations
    weak var gameListRouter: GameListRoutable?

    /// Manage logic operations
    var gameListViewModel: GameListViewModel?

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: Will be implemented
    }
}
