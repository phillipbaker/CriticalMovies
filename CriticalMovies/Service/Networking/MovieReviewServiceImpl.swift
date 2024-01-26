//
//  MovieReviewServiceImpl.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 1/24/22.
//

import UIKit

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return (dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask) as URLSessionDataTaskProtocol
    }
}


protocol MovieReviewService {
    func load(_ resource: ArticleSearchResource, completion: @escaping (Result<ArticleSearchResult, NetworkingError>) -> Void)
}

final class MovieReviewServiceImpl: MovieReviewService {
    private var dataTask: URLSessionDataTask?
    
    var session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func load(_ resource: ArticleSearchResource, completion: @escaping (Result<ArticleSearchResult, NetworkingError>) -> Void) {
        
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
                let result = try JSONDecoder().decode(ArticleSearchResult.self, from: data)
                DispatchQueue.main.async { completion(.success(result)) }
            } catch {
                print(error)
                DispatchQueue.main.async { completion(.failure(.invalidData)) }
            }
        } as? URLSessionDataTask
        
        dataTask?.resume()
    }
}
