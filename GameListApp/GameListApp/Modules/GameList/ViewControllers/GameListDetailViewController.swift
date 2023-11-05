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

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!

    private var isFavorited = false
    private var websiteUrl: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        applyDesign()
        updateBarButtonItem()
    }

    @objc func favoriteButtonTapped() {
        isFavorited = !isFavorited
        updateBarButtonItem()
    }
    
    @IBAction func websiteButtonTapped(_ sender: Any) {
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
