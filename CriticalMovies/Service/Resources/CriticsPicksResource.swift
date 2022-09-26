//
//  CriticsPicksResource.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 1/19/22.
//

import Foundation

struct CriticsPicksResource: APIResource {
    var resourcePath: String { "/picks.json" }
    
    var queryItems: [(String, String?)] {
        [
            ("offset", String(offset))
        ]
    }
    
    var offset: Int
}
