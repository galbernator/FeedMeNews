//
//  CardCoordinator.swift
//  FeedMeNews
//
//  Created by Steve Galbraith on 8/13/20.
//

import SwiftUI

final class CardCoordinator {
    let viewModel: CardViewModel

    init(viewModel: CardViewModel) {
        self.viewModel = viewModel
    }
}

extension CardCoordinator: Coordinator {
    func start() -> AnyView {
        CardView(viewModel: viewModel, coordinator: self).eraseToAnyView()
    }
}

