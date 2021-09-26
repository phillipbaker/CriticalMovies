//
//  Link.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 9/23/21.
//

import Foundation

struct Link: Decodable, Hashable {
    let reviewUrl: String
    
    enum CodingKeys: String, CodingKey {
        case reviewUrl = "url"
    }
}
