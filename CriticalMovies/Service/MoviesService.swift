//
//  MoviesService.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 1/24/22.
//

import UIKit

final class MoviesService {
    static let shared = MoviesService()
    
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
    
    private let cache = NSCache<NSString, UIImage>()
    private var runningRequests = [UUID: URLSessionDataTask]()
    
    func downloadImage(from url: String, withCompletion completion: @escaping (Result<UIImage, MovieError>) -> Void) -> UUID? {
        let cacheKey = NSString(string: url)
        
        guard cache.object(forKey: cacheKey) != MovieImage.placeholder else { return nil }
        
        if let image = cache.object(forKey: cacheKey) {
            completion(.success(image))
            return nil
        }
        
        guard let url = URL(string: url) else {
            completion(.failure(.invalidUrl))
            return nil
        }
        
        let uuid = UUID()
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            defer { self.runningRequests.removeValue(forKey: uuid) }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                self.cache.setObject(image, forKey: cacheKey)
                completion(.success(image))
                return
            }
            
            guard (error! as NSError).code == NSURLErrorCancelled else {
                completion(.failure(.invalidData))
                return
            }
        }
        
        task.resume()
        
        runningRequests[uuid] = task
        return uuid
    }
    
    
    func cancelImageRequest(_ uuid: UUID) {
        runningRequests[uuid]?.cancel()
        runningRequests.removeValue(forKey: uuid)
    }
}
