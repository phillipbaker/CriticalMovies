//
//  MovieReviewService.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 1/24/22.
//

import UIKit

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

final class MovieReviewService {
    private let cache = NSCache<NSString, UIImage>()
    private var dataTask: URLSessionDataTask?
    private var runningRequests = [UUID: URLSessionDataTask]()
    
    var session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func loadMovieReviews(with request: URLRequest, withCompletion completion: @escaping (Result<MovieResult, APIError>) -> Void) {
        
        dataTask = session.dataTask(with: request) { data, response, error in
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
        
        dataTask?.resume()
    }
    
    func downloadImage(from url: String, withCompletion completion: @escaping (Result<UIImage, APIError>) -> Void) -> UUID? {
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
        
        runningRequests[uuid] = dataTask
        return uuid
    }
    
    func cancelImageRequest(_ uuid: UUID) {
        runningRequests[uuid]?.cancel()
        runningRequests.removeValue(forKey: uuid)
    }
}
