//
//  Article.swift
//  FeedMeNews
//
//  Created by Steve Galbraith on 8/11/20.
//

import Foundation

struct ArticleResponse: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let source: Source
    let author: String
    let title: String
    let description: String
    let url: URL
    let imageURL: URL
    let publishedAt: Date
    let summary: String

    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case url
        case imageURL = "urlToImage"
        case publishedAt
        case summary = "content"
    }
}
