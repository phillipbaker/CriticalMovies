//
//  Byline.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 16/01/2024.
//

import Foundation

struct Byline: Decodable {
    let authors: [Author]
    
    func mapToAuthors() -> String {
        return authors
            .compactMap { $0.firstName + " " + $0.lastName }
            .joined(separator: ", ")
    }
    
    enum CodingKeys: String, CodingKey {
        case authors = "person"
    }
}

struct Author: Decodable {
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "firstname"
        case lastName = "lastname"
    }
}
