//
//  CardViewModel.swift
//  FeedMeNews
//
//  Created by Steve Galbraith on 8/13/20.
//

import Foundation

final class CardViewModel: ObservableObject {
    private let article: Article

    init(for article: Article) {
        self.article = article
    }

    var title: String {
        article.title
    }

    var author: String? {
        article.author
    }

    var url: URL {
        article.url
    }

    var imageURL: URL? {
        article.imageURL
    }

    var publishedAtText: String {
        article.formattedPublishedAt
    }

    var sourceName: String {
        article.source.name
    }
}
