//
//  Article.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 12/15/23.
//

import Foundation

struct Article: Decodable {
    let byline: Byline
    let headline: Headline
    let multimedia: [Multimedia?]
    let publicationDate: String
    let summary: String
    let reviewURL: String
    
    private enum CodingKeys: String, CodingKey {
        case byline
        case headline
        case multimedia
        case publicationDate = "pub_date"
        case summary = "snippet"
        case reviewURL = "web_url"
    }
    
    func mapCriticsPick() -> Bool {
        return headline.kicker == "Critic’s Pick" || headline.kicker == "Criticâ€™s Pick"
    }
    
    func mapPublicationDate() -> Date? {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: publicationDate)
    }

    func mapToMovie() -> Movie {
        Movie(
            title: headline.title,
            isCriticsPick: mapCriticsPick(),
            byline: byline.mapToAuthors(),
            summary: summary,
            publicationDate: mapPublicationDate(),
            url: reviewURL,
            image: (Multimedia.mapLargestImage(from: multimedia)?.mapPathToURL())
        )
    }
    
    static func mapArticlesToMovies(articles: [Article]) -> [Movie]? {
        return articles.map { article in
            article.mapToMovie()
        }
    }
}
