//
//  MovieResult.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 9/23/21.
//

import Foundation

struct MovieResult: Decodable {
    let movies: [Movie]?

    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}
