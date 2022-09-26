//
//  ImageService.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 9/26/22.
//

import UIKit

protocol ImageLoading {
    func downloadImage(from url: String, completion: @escaping (Result<UIImage, NetworkingError>) -> Void) -> UUID?
    func cancelImageRequest(_ uuid: UUID)
}

final class ImageService: ImageLoading {
    private let cache = NSCache<NSString, UIImage>()
    
    private var dataTask: URLSessionDataTask?
    private var runningRequests = [UUID: URLSessionDataTask]()

    func downloadImage(from url: String, completion: @escaping (Result<UIImage, NetworkingError>) -> Void) -> UUID? {
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

