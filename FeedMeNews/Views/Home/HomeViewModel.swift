//
//  HomeViewModel.swift
//  FeedMeNews
//
//  Created by Steve Galbraith on 8/11/20.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    @Published var articles = [Article]()
    @Published var error: Error?
    private var response = PassthroughSubject<ArticleResponse, Never>()
    private var cancellables = Set<AnyCancellable>()

    init() {
        setupSubscriptions()
        loadArticles()
    }

    private func setupSubscriptions() {
        response
            .map { $0.articles }
            .assign(to: \.articles, on: self)
            .store(in: &cancellables)
    }

    private func loadArticles() {
        RequestManager.send(.headlines(page: 1, country: "us"))
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                        self?.error = error
                    default:
                        return
                    }
                },
                receiveValue: { [weak self] response in
                    DispatchQueue.main.async {
                        self?.response.send(response)
                    }
                }
            )
            .store(in: &cancellables)
    }
}
