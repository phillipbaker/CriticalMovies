//
//  Multimedia.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 1/24/22.
//

import Foundation

struct Multimedia: Decodable, Hashable {
    let imageUrl: String

    enum CodingKeys: String, CodingKey {
        case imageUrl = "src"
    }
}
