//
//  ArticleSearchAPI.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 12/15/23.
//

import Foundation

enum ArticleSearchAPI {
    static var scheme = "https"
    static var host = "api.nytimes.com"
    static var path = "/svc/search/v2/articlesearch.json"
    static var key = (name: "api-key", value: "yUjVIKgnTM6zSrC20DKJ01w84aGPdT5n")
}
