//
//  UIImageAdditions.swift
//  GameListApp
//
//  Created by Erdi Kanık on 4.11.2023.
//

import Foundation
import UIKit

extension UIImageView {

    func load(url: String?, imageName: String) {
        DispatchQueue.main.async {

            let imageData = FileUtil.getFile(by: imageName)

            guard imageData == nil else {
                DispatchQueue.main.async {
                    self.image = UIImage(data: imageData ?? Data())
                }
                return
            }

            guard let url = url, let imageUrl = URL(string: url) else {
                return
            }

            self.backgroundColor = .white

            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: imageUrl) {
                    if let image = UIImage(data: data) {
                        FileUtil.saveFile(by: imageName, data: data)
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
}
