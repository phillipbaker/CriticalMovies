//
//  MoviesService.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 1/24/22.
//

import UIKit

final class MoviesService {
    static let shared = MoviesService()
    
    let cache = NSCache<NSString, UIImage>()
    
    func fetchMovies(from url: URL, withCompletion completion: @escaping (Result<MovieResult, MovieError>) -> Void) {
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
                let result = try JSONDecoder().decode(MovieResult.self, from: data)
                DispatchQueue.main.async { completion(.success(result)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(.invalidData)) }
            }
        }
        
        task.resume()
    }
    
    func downloadImage(from url: String, withCompletion completion: @escaping (Result<UIImage, MovieError>) -> Void) {
        let cacheKey = NSString(string: url)
        
        if let image = cache.object(forKey: cacheKey) {
            completion(.success(image))
            return
        }
        
        guard let url = URL(string: url) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data)
            else {
                completion(.failure(.invalidData))
                return
            }
            self.cache.setObject(image, forKey: cacheKey)
            completion(.success(image))
        }
        
        task.resume()
    }
}
