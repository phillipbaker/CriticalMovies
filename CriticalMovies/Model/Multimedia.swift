//
//  Multimedia.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 1/24/22.
//

import Foundation

struct Multimedia: Decodable {
    let imageWidth: Int
    let path: String
    
    func mapPathToURL() -> String {
        return "https://nytimes.com/" + path
    }
    
    enum CodingKeys: String, CodingKey {
        case imageWidth = "width"
        case path = "url"
    }
    
    static func mapLargestImage(from multimedia: [Multimedia?]) -> Multimedia? {
        return multimedia
            .compactMap { $0 }
            .sorted(by: { $0.imageWidth > $1.imageWidth })
            .first
    }
}
