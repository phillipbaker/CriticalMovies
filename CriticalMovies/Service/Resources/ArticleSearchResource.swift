//
//  ArticleSearchResource.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 12/15/23.
//

import Foundation

protocol ArticleSearchResource {
    var queryItems: [(String, String?)] { get }
}

extension ArticleSearchResource {
    var host: String { ArticleSearchAPI.host }
    var scheme: String { ArticleSearchAPI.scheme }
 
    var url: URL? {
        var components = URLComponents()
        
        components.host = host
        components.scheme = scheme
        components.path = ArticleSearchAPI.path
        components.queryItems = []
        
        let apiKey = URLQueryItem(name: ArticleSearchAPI.key.name, value: ArticleSearchAPI.key.value)
        
        components.queryItems?.append(apiKey)
        components.queryItems?.append(contentsOf: resourceQueryItems)
        return components.url
    }
    
    var resourceQueryItems: [URLQueryItem] {
        var resourceQueryItems = [URLQueryItem]()
        
        for (name, value) in queryItems where value != nil {
            let queryItem = URLQueryItem(name: name, value: value)
            resourceQueryItems.append(queryItem)
        }
        
        return resourceQueryItems
    }
}
