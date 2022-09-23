//
//  NYTimesAPI.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 9/10/22.
//

import Foundation

enum NYTimesAPI {
    static var scheme = "https"
    static var host = "api.nytimes.com"
    static var sharedPath = "/svc/movies/v2/reviews"
    static var key = (name: "api-key", value: "INSERT_API_KEY_HERE")
    
    static var searchPath = "/search.json"
    static var criticsPath = "/picks.json"
}
