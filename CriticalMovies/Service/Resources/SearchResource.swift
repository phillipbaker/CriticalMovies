//
//  SearchResource.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 1/25/22.
//

import Foundation

struct SearchResource: ApiResource {
    typealias ModelType = Movie

    var offset: Int
    var reviewer: String?
    var searchQuery: String?
    var methodPath: String { return ApiConstant.searchPath }
}
