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
    let author: String?
    let title: String
    let description: String
    let url: URL
    let imageURL: URL?
    let publishedAt: Date
    let content: String

    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case url
        case imageURL = "urlToImage"
        case publishedAt
        case content
    }

    init(source: Source, author: String, title: String, description: String, url: URL, imageURL: URL?, publishedAt: Date, content: String) {
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.imageURL = imageURL
        self.publishedAt = publishedAt
        self.content = content
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        source = try container.decode(Source.self, forKey: .source)
        author = try container.decodeIfPresent(String.self, forKey: .author)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        url = try container.decode(URL.self, forKey: .url)
        let imageURLString = try container.decodeIfPresent(String.self, forKey: .imageURL) ?? ""
        imageURL = URL(string: imageURLString)
        publishedAt = try container.decode(Date.self, forKey: .publishedAt)
        content = try container.decodeIfPresent(String.self, forKey: .content) ?? ""
    }

    var formattedPublishedAt: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a d MMM YYYY"
        return formatter.string(from: publishedAt)
    }
}

extension Article: Hashable {
    static func == (lhs: Article, rhs: Article) -> Bool {
        lhs.url == rhs.url
    }
}

extension Article {
    static var example: Article {
        let source = Source(id: nil, name: "TNN")
        return Article(
            source: source,
            author: "Rob Robertson",
            title: "Three Kids Run Wild in House in Eagle Mountain",
            description: "Three boys run wild while \"playing\" and make a clean house a disaster.",
            url: URL(string: "https://www.google.com")!,
            imageURL: URL(string: "https://pixabay.com/photos/kitty-cat-kitten-pet-animal-cute-551554/")!,
            publishedAt: Date(),
            content: "Three boys run wild while \"playing\" and make a clean house a disaster.")
    }
}
