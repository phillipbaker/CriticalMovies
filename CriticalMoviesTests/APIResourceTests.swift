//
//  APIResourceTests.swift
//  CriticalMoviesTests
//
//  Created by Phillip Baker on 9/7/22.
//

import XCTest
@testable import CriticalMovies

class APIResourceTests: XCTestCase {
    
    func test_criticsPickResource_makesValidResourceURL() {
        let offset = 0
        let resource = CriticsPicksResource(offset: offset)
        
        XCTAssertEqual(resource.host, "api.nytimes.com", "API resource host")
        XCTAssertEqual(resource.resourcePath, "/picks.json", "Critics Pick resource path")
        XCTAssertEqual(resource.offset, offset, "Critics Pick resource offset")
       
        XCTAssertEqual(
            resource.url,
            URL(string: "https://api.nytimes.com/svc/movies/v2/reviews/picks.json?api-key=7mZQQ5atRHInAGiRitXjfpiNhKqgCIKj&offset=0"),
            "Critics Pick resource URL string"
        )
    }
    
    func test_searchResource_withoutSearchQuery_makesValidResourceURL() {
        let offset = 0
        let resource = SearchResource(offset: offset)
        
        XCTAssertEqual(resource.host, "api.nytimes.com", "API resource host")
        XCTAssertEqual(resource.resourcePath, "/search.json", "Search resource path")
        XCTAssertEqual(resource.offset, offset, "Search resource offset")
        XCTAssertEqual(resource.searchQuery, nil, "Search resource search query")
        
        XCTAssertEqual(
            resource.url,
            URL(string: "https://api.nytimes.com/svc/movies/v2/reviews/search.json?api-key=7mZQQ5atRHInAGiRitXjfpiNhKqgCIKj&offset=0"),
            "Search resource URL string"
        )
    }
    
    func test_searchResource_withSearchQuery_makesValidResourceURL() {
        let offset = 3
        let resource = SearchResource(offset: offset, searchQuery: "Year")
        
        XCTAssertEqual(resource.host, "api.nytimes.com", "API resource host")
        XCTAssertEqual(resource.resourcePath, "/search.json", "Search resource path")
        XCTAssertEqual(resource.offset, offset, "Search resource offset")
        XCTAssertEqual(resource.searchQuery, "Year", "Search resource search query")
        
        XCTAssertEqual(
            resource.url,
            URL(string: "https://api.nytimes.com/svc/movies/v2/reviews/search.json?api-key=7mZQQ5atRHInAGiRitXjfpiNhKqgCIKj&offset=3&query=Year"),
            "Search resource URL string"
        )
    }
    
}
