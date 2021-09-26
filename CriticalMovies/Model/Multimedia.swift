//
//  Multimedia.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 9/23/21.
//

import Foundation

struct Multimedia: Decodable, Hashable {
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "src"
    }
}
