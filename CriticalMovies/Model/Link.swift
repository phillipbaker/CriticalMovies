//
//  Link.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 1/24/22.
//

import Foundation

struct Link: Decodable, Hashable {
    let reviewUrl: String

    enum CodingKeys: String, CodingKey {
        case reviewUrl = "url"
    }
}
