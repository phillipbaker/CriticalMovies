//
//  Headline.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 16/01/2024.
//

import Foundation

struct Headline: Decodable {
    let title: String
    let kicker: String?
    
    private enum CodingKeys: String, CodingKey {
        case title = "main"
        case kicker
    }
}
