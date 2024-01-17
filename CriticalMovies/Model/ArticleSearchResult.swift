//
//  ArticleSearchResult.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 16/01/2024.
//

import Foundation

struct ArticleSearchResult: Decodable {
    let response: Response
}

struct Response: Decodable {
    let articles: [Article]
    
    private enum CodingKeys: String, CodingKey {
        case articles = "docs"
    }
}
