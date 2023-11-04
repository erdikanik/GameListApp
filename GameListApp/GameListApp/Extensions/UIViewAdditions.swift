//
//  UIViewAdditions.swift
//  GameListApp
//
//  Created by Erdi Kanık on 4.11.2023.
//

import UIKit

extension UIView {

    static func reuseIdentifier() -> String {

        return String(describing: self)
    }

    static func nibName() -> String {

        return String(describing: self)
    }

    static func nib() -> UINib {
        return UINib(nibName: nibName(), bundle: nil)
    }
}
