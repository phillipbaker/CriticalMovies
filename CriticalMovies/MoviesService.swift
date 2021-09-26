//
//  MoviesService.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 9/22/21.
//

import UIKit

protocol MoviesService {
    func fetchMovies(withCompletion completion: @escaping (Result<CriticsPicks,MovieError>) -> Void)
}

final class CriticsPicksService: MoviesService {
    
    static let shared = CriticsPicksService()
    private init() {}
    
    let cache = NSCache<NSString, UIImage>()
    
    func fetchMovies(withCompletion completion: @escaping (Result<CriticsPicks,MovieError>) -> Void) {
        let criticsPicksUrl = APIConstants.baseUrl.appending(APIConstants.criticsPicks + "?" + "api-key=\(APIConstants.apiKey)")
        
        guard let url = URL(string: criticsPicksUrl) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.invalidApiKey))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let criticsPicks = try JSONDecoder().decode(CriticsPicks.self, from: data)
                // Do main thread here or at call site?
                DispatchQueue.main.async { completion(.success(criticsPicks)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(.invalidData)) }
            }
        }
        
        task.resume()
    }
    
    func downloadImage(from urlString: String, withCompletion completion: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
            let data = data,
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
