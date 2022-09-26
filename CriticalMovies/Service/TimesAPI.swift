//
//  TimesAPI.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 9/10/22.
//

import Foundation

enum TimesAPI {
    static var scheme = "https"
    static var host = "api.nytimes.com"
    static var sharedPath = "/svc/movies/v2/reviews"
    static var key = (name: "api-key", value: "INSERT_API_KEY_HERE")
}
