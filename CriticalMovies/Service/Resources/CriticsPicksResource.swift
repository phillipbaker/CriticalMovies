//
//  CriticsPicksResource.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 1/19/22.
//

import Foundation

struct CriticsPicksResource: ArticleSearchResource {    
    var queryItems: [(String, String?)] {[
        ("fq", "section_name:Movies AND type_of_material:Review AND kicker: \("(Critic’s Pick)")"),
        ("sort", "newest"),
        ("page", String(offset))
    ]}
    
    var offset: Int
}
