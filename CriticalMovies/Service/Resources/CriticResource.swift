//
//  CriticResource.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 1/19/22.
//

import Foundation

struct CriticResource: APIResource {
    typealias ModelType = Movie

    var offset: Int
    var reviewer: String?
    var searchQuery: String?
    var methodPath: String { return APIConstant.criticPath }
}
