//
//  EventsController.swift
//  Sport Riot
//
//  Created by Jesse Ruiz on 12/16/20.
//

import UIKit

class EventsController {
    
    // MARK: - Properties
    private let baseURL = URL(string: "https://api.seatgeek.com/2/events")
    private let cache = NSCache<NSString, UIImage>()
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    // MARK: - Methods
    /// A function to grab all the events.
    /// - Parameters:
    ///   - page: This indicates what page you are on. Page number is 1-indexed and starts at 1.
    ///   - completion: Completes the function with an Event result or with an error result.
    func getEvents(page: Int, completion: @escaping (Result<Event, SRError>) -> Void) {
        let queryParameters: [String: String] = [
            "per_page": "30",
            "page": "\(page)",
            "client_id": ClientKey.clientKey
        ]
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.seatgeek.com"
        urlComponents.path = "/2/events"
        urlComponents.setQueryItems(with: queryParameters)
        
        guard let requestURL = urlComponents.url else {
            completion(.failure(.invalidResponse))
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let task = session.dataTaskWithURL(url: requestURL) { data, response, error in
            
            if let error = error {
                completion(.failure(.unableToComplete))
                NSLog("\(error)")
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let events = try decoder.decode(Event.self, from: data)
                completion(.success(events))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    /// A function to grab the images from the API.
    /// - Parameters:
    ///   - urlString: The image string you pass in to retrieve the image from the API.
    ///   - completion: Completes the function with an UIImage.
    func getEventImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {

        let cacheKey = NSString(string: urlString)

        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }

        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, _ in

            guard let data = data,
                  let image = UIImage(data: data) else {
                completion(nil)
                return
            }

            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        task.resume()
    }
}
