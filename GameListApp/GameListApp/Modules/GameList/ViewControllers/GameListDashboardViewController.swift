//
//  GameListDashboardViewController.swift
//  GameListApp
//
//  Created by Erdi Kanık on 4.11.2023.
//

import Foundation
import UIKit

final class GameListDashboardViewController: UIViewController {

    private enum Constant {

        static let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    /// Manage route operations
    weak var gameListRouter: GameListRoutable?

    /// Manage logic operations
    var gameListViewModel: GameListViewModel?

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var games: [Game] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView?.register(
            UINib.init(nibName: GameGridCell.reuseIdentifier(),
                       bundle: Bundle.main),
            forCellWithReuseIdentifier: GameGridCell.reuseIdentifier())

        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.estimatedItemSize = .zero

        gameListViewModel?.stateChangeHandler = { [weak self] state in
            DispatchQueue.main.async {
                switch state {
                case .initialGamesFetched(let games):
                    self?.games = games
                    self?.collectionView.reloadData()
                case .error(_):
                    // TODO: Will be implemented
                    break
                }
            }
        }

        gameListViewModel?.fetchInitialGames()
    }

    override func viewWillLayoutSubviews() {
       super.viewWillLayoutSubviews()
       self.collectionView.collectionViewLayout.invalidateLayout()
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
    }
}

// MARK: UICollectionViewDataSource

extension GameListDashboardViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return games.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: GameGridCell.reuseIdentifier(),
            for: indexPath) as! GameGridCell

        let game = games[indexPath.row]

        cell.name = game.name ?? ""
        cell.genres = game.genres?.compactMap { $0.name }.joined(separator: ",") ?? ""
        cell.rating = game.metacritic
        cell.gameImageView.load(url: game.imageUrl)
        cell.backgroundColor = .red
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: Will be implemented
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension GameListDashboardViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let isLandscape = UIDevice.current.orientation.isLandscape

        let width = (view.frame.width - (3 * Constant.sectionInsets.left)) /  (isLandscape ? 3 : 1)
        return CGSize(width: width , height: width)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return Constant.sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constant.sectionInsets.left
    }
}
