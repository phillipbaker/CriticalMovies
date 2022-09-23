//
//  SearchResource.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 1/25/22.
//

import Foundation

struct SearchResource: APIResource {
    var resourcePath: String { NYTimesAPI.searchPath }
    
    var queryItems: [(String, String?)] {
        [
            ("offset", String(offset)),
            ("query", searchQuery)
        ]
    }
    
    var offset: Int
    var searchQuery: String?
}
