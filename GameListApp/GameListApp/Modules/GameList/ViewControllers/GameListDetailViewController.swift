//
//  GameListDetailViewController.swift
//  GameListApp
//
//  Created by Erdi Kanık on 5.11.2023.
//

import Foundation
import UIKit

final class GameListDetailViewController: UIViewController {

    weak var router: GameListRouter?
    var viewModel: GameListDetailViewModelInterface?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    private var isFavorited = false
    private var websiteUrl: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.stateChangeHandler = { [weak self] state in

            switch state {
            case .gameDetailsFetched(let game):
                self?.imageView.load(url: game.imageUrl, imageName: game.imageUrl?.urlComponentsLastItem() ?? "")
                self?.websiteUrl = game.website
                DispatchQueue.main.async {
                    self?.textView.text = game.description
                    self?.nameLabel.text = game.name
                }
            case .error(_):
                // TODO: Will be implemented
                break
            }
        }

        applyDesign()
        updateBarButtonItem()

        viewModel?.retrieveGameDetails()
    }

    @objc func favoriteButtonTapped() {
        isFavorited = !isFavorited
        updateBarButtonItem()

        if (isFavorited) {
            viewModel?.addToFavorites()
        } else {
            viewModel?.removeFromFavorites()
        }
    }
    
    @IBAction func websiteButtonTapped(_ sender: Any) {
        guard let websiteUrl, let url = URL(string: websiteUrl) else {
            return
        }
        UIApplication.shared.open(url)
    }
    
    private func updateBarButtonItem() {
        let rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: isFavorited ? "star.fill" : "star"),
            style: .done,
            target: self,
            action: #selector(favoriteButtonTapped)
        )

        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
}

private extension GameListDetailViewController {

    func applyDesign() {
        websiteButton.setTitle(NSLocalizedString("Open website", comment: ""), for: .normal)
    }
}
