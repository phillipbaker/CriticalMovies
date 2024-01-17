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
        let apiKey = ArticleSearchAPI.key.value
        
        XCTAssertEqual(resource.host, "api.nytimes.com", "API resource host")
        XCTAssertEqual(resource.offset, offset, "Critics Pick resource offset")
        
        XCTAssertEqual(resource.url, URL(string: "https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=\(apiKey)&fq=section_name:Movies%20AND%20type_of_material:Review%20AND%20kicker:%20(Critic%E2%80%99s%20Pick)&sort=newest&page=0"), "Critics Pick resource URL string"
        )
        
    }
    
    func test_searchResource_withoutSearchQuery_makesValidResourceURL() {
        let offset = 0
        let resource = SearchResource(offset: offset)
        let apiKey = ArticleSearchAPI.key.value
        
        XCTAssertEqual(resource.host, "api.nytimes.com", "API resource host")
        XCTAssertEqual(resource.offset, offset, "Search resource offset")
        XCTAssertEqual(resource.searchQuery, nil, "Search resource search query")
        
        XCTAssertEqual(resource.url,URL(string: "https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=\(apiKey)&fq=section_name:Movies%20AND%20type_of_material:Review&sort=newest&page=0"), "Search resource URL string"
        )
    }
    
    func test_searchResource_withSearchQuery_makesValidResourceURL() {
        let offset = 3
        let resource = SearchResource(offset: offset, searchQuery: "Year")
        let apiKey = ArticleSearchAPI.key.value
        
        XCTAssertEqual(resource.host, "api.nytimes.com", "API resource host")
        XCTAssertEqual(resource.offset, offset, "Search resource offset")
        XCTAssertEqual(resource.searchQuery, "Year", "Search resource search query")
        
        XCTAssertEqual(resource.url,URL(string: "https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=\(apiKey)&fq=section_name:Movies%20AND%20type_of_material:Review&sort=newest&page=3&q=Year"), "Search resource URL string"
        )
    }
    
}
