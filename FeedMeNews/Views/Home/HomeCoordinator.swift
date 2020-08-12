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
}

extension HomeCoordinator: Coordinator {
    func start() -> AnyView {
        HomeView(viewModel: viewModel, coordinator: self).eraseToAnyView()
    }
}
