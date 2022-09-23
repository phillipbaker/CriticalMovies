//
//  Movie.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 9/21/21.
//

import Foundation

struct Movie: Hashable {
    let identifier = UUID()
    let title: String
    let criticsPick: Int
    let byline: String
    let headline: String
    let summary: String
    let publicationDate: String
    let link: Link
    let multimedia: Multimedia?

    static func ==(lhs: Movie, rhs: Movie) -> Bool {
        return lhs.link == rhs.link
    }
}

extension Movie: Decodable {
    enum CodingKeys: String, CodingKey {
        case byline, headline, link, multimedia
        case title = "display_title"
        case criticsPick = "critics_pick"
        case summary = "summary_short"
        case publicationDate = "publication_date"
    }
}
