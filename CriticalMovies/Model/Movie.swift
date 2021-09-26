//
//  Movie.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 9/21/21.
//

import Foundation

struct Movie: Decodable, Hashable {
    let identifier = UUID()
    let title: String
    let byline: String
    let headline: String
    let summary: String
    let link: Link
    let multimedia: Multimedia
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    enum CodingKeys: String, CodingKey {
        case title = "display_title"
        case byline
        case headline
        case summary = "summary_short"
        case link
        case multimedia
    }
}
