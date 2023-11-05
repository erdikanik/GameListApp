//
//  AlertView.swift
//  GameListApp
//
//  Created by Erdi Kanık on 5.11.2023.
//

import Foundation
import UIKit

final class AlertView {

    static func showAlertView(
        message: String,
        okButton: String,
        cancelButton: String,
        completion: @escaping ((Bool)->(Void))) -> UIAlertController {

        let alertController = UIAlertController(
            title: "",
            message: message,
            preferredStyle: .alert
        )

        alertController.addAction(UIAlertAction(title: okButton, style: .default, handler: { action in
            completion(true)
        }))

        alertController.addAction(UIAlertAction(title: cancelButton, style: .default, handler: { action in
            completion(false)
        }))

        return alertController
    }
}
