//
//  HomeCoordinator.swift
//  FeedMeNews
//
//  Created by Steve Galbraith on 8/11/20.
//

import SwiftUI

final class HomeCoordinator {
    let viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    func card(for article: Article) -> AnyView {
        view(for: .card(article))
    }

    func destination(for article: Article) -> AnyView {
        view(for: .article(article.url))
    }
}

extension HomeCoordinator: Coordinator {
    func start() -> AnyView {
        HomeView(viewModel: viewModel, coordinator: self).eraseToAnyView()
    }
}

extension HomeCoordinator: Navigator {
    enum Destination {
        case article(URL)
        case card(Article)
    }

    func view(for destination: Destination) -> AnyView {
        switch destination {
        case .card(let article):
            let viewModel = CardViewModel(for: article)
            let coordinator = CardCoordinator(viewModel: viewModel)

            return coordinator.start()
        case .article(let url):
            return VStack {
                Text("Coming Soon")
                    .padding()

                Text(url.absoluteString)
                    .padding()
            }
            .eraseToAnyView()
        }
    }
}
