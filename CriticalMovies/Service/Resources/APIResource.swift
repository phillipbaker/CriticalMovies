//
//  APIResource.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 1/19/22.
//

import Foundation

protocol APIResource {
    var resourcePath: String { get }
    var queryItems: [(String, String?)] { get }
}

extension APIResource {
    
    var host: String { NYTimesAPI.host }
    var scheme: String { NYTimesAPI.scheme }
 
    var url: URL? {
        var components = URLComponents()
        
        components.host = host
        components.scheme = scheme
        
        components.path = NYTimesAPI.sharedPath
        components.path.append(resourcePath)
        
        components.queryItems = []
        
        let apiKey = URLQueryItem(name: NYTimesAPI.key.name, value: NYTimesAPI.key.value)
        
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
