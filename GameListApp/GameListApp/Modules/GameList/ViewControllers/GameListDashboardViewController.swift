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
    private var selectedGameIds: [Int] = []

    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        applySearchControllerSettings()

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

private extension GameListDashboardViewController {

    func applySearchControllerSettings() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("Game", comment: "")
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

// MARK: ScrollView

extension GameListDashboardViewController {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionView &&
            (collectionView.contentOffset.y >=
             (collectionView.contentSize.height - collectionView.frame.size.height)) {
            gameListViewModel?.needNewPage()
        }
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
        cell.rating = game.metacritic ?? 0
        cell.gameImageView.load(url: game.imageUrl, imageName: game.imageUrl?.urlComponentsLastItem() ?? "")

        cell.backgroundColor = selectedGameIds.contains(game.gameId) ? .gray : .clear
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let game = games[indexPath.row]
        if !selectedGameIds.contains(where: { $0 == game.gameId }) {
            selectedGameIds.append(game.gameId)
        }
        collectionView.cellForItem(at: indexPath)?.backgroundColor = .gray
        gameListRouter?.routeToDetail(gameId: game.gameId)
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

// MARK: UISearchResultsUpdating

extension GameListDashboardViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        if searchBar.text == nil || searchBar.text?.count == 0 {
            gameListViewModel?.fetchInitialGames()
        } else {
            if let text = searchBar.text {
                gameListViewModel?.searchGame(parameterKey: text)
            }
        }
    }
}
