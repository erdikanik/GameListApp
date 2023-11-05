//
//  GameListDataSource.swift
//  GameListApp
//
//  Created by Erdi Kanık on 5.11.2023.
//

import Foundation

protocol GameListDataSourceInterface {

    /// Add game object to favorites
    /// - Parameter game: Game objects
    func addToFavorites(game: Game)

    /// Retrieves all favorite game objects
    /// - Returns: Game object array
    func favorites() -> [Game]

    /// Removes from favorites
    func remove(gameId: Int)
}

final class GameListDataSource {

    @Storage(key: "favorites_key")
    private static var favoriteGames: [Game]?
}

extension GameListDataSource: GameListDataSourceInterface {

    func addToFavorites(game: Game) {
        if GameListDataSource.favoriteGames == nil {
            GameListDataSource.favoriteGames = [game]
        } else {
            if GameListDataSource.favoriteGames?.firstIndex(where: { $0.gameId == game.gameId }) == nil {
                GameListDataSource.favoriteGames?.append(game)
            }
        }
    }
    
    func favorites() -> [Game] {
        return GameListDataSource.favoriteGames ?? []
    }
    
    func remove(gameId: Int) {
        GameListDataSource.favoriteGames?.removeAll(where: { $0.gameId == gameId })
    }

    @propertyWrapper
    struct Storage {
        private let key: String

        init(key: String) {
            self.key = key
        }

        var wrappedValue: [Game]? {
            get {
                guard let data = UserDefaults.standard.data(forKey: key),
                      let model = try? JSONDecoder().decode([Game].self, from: data) else
                {
                    return nil
                }

                return model
            }
            set {
                if let newValue = newValue {
                    let decoder = JSONEncoder()
                    if let data = try? decoder.encode(newValue) {
                        UserDefaults.standard.set(data, forKey: key)
                    }
                } else {
                    UserDefaults.standard.set(nil, forKey: key)
                }
            }
        }
    }
}
