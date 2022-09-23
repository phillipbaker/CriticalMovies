//
//  APIError.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 9/23/21.
//

import Foundation

enum APIError: String, Error {
    case invalidUrl = "Invalid URL"
    case invalidApiKey = "Invalid API Key"
    case invalidResponse = "Unable to Load Movies"
    case invalidData = "Unable to Present Movies"
}
