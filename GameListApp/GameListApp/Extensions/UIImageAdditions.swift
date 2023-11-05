//
//  UIImageAdditions.swift
//  GameListApp
//
//  Created by Erdi Kanık on 4.11.2023.
//

import Foundation
import UIKit

extension UIImageView {

    func load(url: String?) {
        DispatchQueue.main.async {
            self.backgroundColor = .white

            guard let url = url, let imageUrl = URL(string: url) else {
                return
            }

            DispatchQueue.global().async { [weak self] in
                guard let data = try? Data(contentsOf: imageUrl),
                    let image = UIImage(data: data) else { return }

                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
