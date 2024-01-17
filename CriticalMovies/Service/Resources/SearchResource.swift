//
//  SearchResource.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 1/25/22.
//

import Foundation

struct SearchResource: ArticleSearchResource {
    var queryItems: [(String, String?)] {[
        ("fq", "section_name:Movies AND type_of_material:Review"),
        ("sort", "newest"),
        ("page", String(offset)),
        ("q", searchQuery)
    ]}
    
    var offset: Int
    var searchQuery: String?
}
