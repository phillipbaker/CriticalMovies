//
//  MovieError.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 9/23/21.
//

import Foundation

enum MovieError: Error {
    case invalidUrl
    case invalidApiKey
    case invalidResponse
    case invalidData
}
