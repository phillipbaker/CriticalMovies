//
//  Byline.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 16/01/2024.
//

import Foundation

struct Byline: Decodable {
    let original: String
    
    func mapToAuthors() -> String {
        return String(original.dropFirst(3))
    }
}
