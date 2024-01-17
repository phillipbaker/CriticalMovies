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
    let isCriticsPick: Bool
    let byline: String
    let summary: String
    let publicationDate: Date?
    let url: String
    let image: String?

    static func ==(lhs: Movie, rhs: Movie) -> Bool {
        return lhs.url == rhs.url
    }
}
