//
//  APIResource.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 1/19/22.
//

import Foundation

protocol APIResource {
    associatedtype ModelType: Decodable
    
    var offset: Int { get set }
    var reviewer: String? { get set }
    var searchQuery: String? { get set }
    var methodPath: String { get }
}

extension APIResource {
    var url: URL {
        var components = URLComponents(string: APIConstant.baseUrl)!
        components.path = methodPath
        
        components.queryItems = [
            URLQueryItem(name: "api-key", value: APIConstant.apiKey),
            URLQueryItem(name: "offset", value: String(offset))
        ]
        
        if let reviewer = reviewer {
            components.queryItems?.append(URLQueryItem(name: "criticspick", value: "y"))
            components.queryItems?.append(URLQueryItem(name: "reviewer", value: reviewer))
        }
        
        if let searchQuery = searchQuery {
            components.queryItems?.append(URLQueryItem(name: "query", value: searchQuery))
        }
        
        return components.url!
    }
}
