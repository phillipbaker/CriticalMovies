//
//  TestHelpers.swift
//  CriticalMoviesTests
//
//  Created by Phillip Baker on 9/27/21.
//

import XCTest

func executeRunLoop() {
    RunLoop.current.run(until: Date())
}

func response(statusCode: Int) -> HTTPURLResponse? {
    HTTPURLResponse(
        url: URL(string: "http://www.dummyurl.com/")!,
        statusCode: statusCode,
        httpVersion: nil,
        headerFields: nil
    )
}

func jsonData() -> Data {
        """
    {
        "status":"OK",
        "copyright":"Copyright (c) 2022 The New York Times Company. All Rights Reserved.",
        "has_more":true,
        "num_results":20,
        "results":[
            {
                "display_title":"Stay on Board: The Leo Baker Story",
                "mpaa_rating":"",
                "critics_pick":1,
                "byline":"Teo Bugbee",
                "headline":"‘Stay on Board: The Leo Baker Story’ Review: Surviving the Grind",
                "summary_short":"In this documentary, a professional skateboarder turns down the Olympics for the chan  to live openly.",
                "publication_date":"2022-08-11",
                "opening_date":"2022-08-11",
                "date_updated":"2022-08-11 11:14:04",
                "link":{
                "type":"article",
                "url":"https://www.nytimes.com/2022/08/11/movies/stay-on-board-the-leo-baker-story-review.html",
                "suggested_link_text":"Read the New York Times Review of Stay on Board: The Leo Baker Story"
                },
                "multimedia":{
                "type":"mediumThreeByTwo210",
                "src":"https://static01.    .com/images/2022/08/12/arts/11leo-baker-review1/11leo-baker-review1-mediumThreeByTwo440.jpg",
                "height":140,
                "width":210
            }
        }]
    }
    """.data(using: .utf8)!
}
