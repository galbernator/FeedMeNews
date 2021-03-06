//
//  FeedMeNewsApp.swift
//  FeedMeNews
//
//  Created by Steve Galbraith on 8/11/20.
//

import SwiftUI

@main
struct FeedMeNewsApp: App {
    var body: some Scene {
        WindowGroup<AnyView> {
            let viewModel = HomeViewModel()
            let coordinator = HomeCoordinator(viewModel: viewModel)
            return coordinator.start()
        }
    }
}
