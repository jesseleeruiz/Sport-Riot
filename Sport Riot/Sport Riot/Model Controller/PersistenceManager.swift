//
//  PersistenceManager.swift
//  Sport Riot
//
//  Created by Jesse Ruiz on 12/21/20.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    /// Updates the persistence manager with an event, the action (adding or removing), and the completion. You call this function when you are adding or removing from the persistence manager.
    /// - Parameters:
    ///   - favorite: This is the event the consumer is favoriting.
    ///   - actionType: The action you are doing towards the persistence manager; either adding or removing an event.
    ///   - completion: Completes this function with a success, adding or removing an event, or an error.
    static func updateWith(favorite: Event.Events, actionType: PersistenceActionType, completion: @escaping (SRError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                var retrievedFavorites = favorites
                
                switch actionType {
                case .add:
                    guard !retrievedFavorites.contains(favorite) else {
                        completion(.alreadyInFavorites)
                        return
                    }
                    retrievedFavorites.append(favorite)
                    
                case .remove:
                    retrievedFavorites.removeAll { $0.id == favorite.id }
                }
                completion(save(favorites: retrievedFavorites))
                
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    /// Retrieves all the favorited events.
    /// - Parameter completion: Completes the function with returning the event if it is favorited or an error if something went wrong.
    static func retrieveFavorites(completion: @escaping (Result<[Event.Events], SRError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completion(.success([]))
            return
        }
        do {
            let favorites = try JSONDecoder().decode([Event.Events].self, from: favoritesData)
            completion(.success(favorites))
        } catch {
            completion(.failure(.unableToFavorite))
        }
    }
    
    /// Saves an event to the persistence manager.
    /// - Parameter favorites: An event.
    /// - Returns: Returns nil if you were able to favorite the event or an error if it was unable to favorite an event.
    static func save(favorites: [Event.Events]) -> SRError? {
        do {
            let encodedFavorites = try JSONEncoder().encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
