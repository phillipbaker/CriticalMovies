//
//  DataService.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 1/24/22.
//

import UIKit

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}


protocol DataLoading {
    func load(_ resource: APIResource, completion: @escaping (Result<MovieResult, NetworkingError>) -> Void)
}

final class DataService: DataLoading {
    private var dataTask: URLSessionDataTask?
    
    var session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func load(_ resource: APIResource, completion: @escaping (Result<MovieResult, NetworkingError>) -> Void) {
        
        guard let url = resource.url else {
            completion(.failure(.invalidUrl))
            return
        }
        
        let request = URLRequest(url: url)
        
        
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
}
