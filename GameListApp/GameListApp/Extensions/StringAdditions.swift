//
//  StringAdditions.swift
//  GameListApp
//
//  Created by Erdi Kanık on 5.11.2023.
//

import Foundation

extension String {

    /// Check url components and return last item after '/'
    /// - Returns: Last item of url components
    func urlComponentsLastItem() -> String {

        components(separatedBy: "/").last ?? ""
    }
}
