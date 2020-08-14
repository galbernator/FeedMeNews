//
//  HomeView.swift
//  FeedMeNews
//
//  Created by Steve Galbraith on 8/11/20.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedArticle: Article?
    @ObservedObject var viewModel: HomeViewModel
    let coordinator: HomeCoordinator


    var body: some View {
        NavigationView {
            if self.viewModel.articles.isEmpty {
                Text("Loading your articles...")
            } else {
                List {
                    ForEach(self.viewModel.articles, id: \.title) { article in
                        self.coordinator.card(for: article)
                    }
                }
                .navigationBarTitle(Text("Headlines"))
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = HomeViewModel()
        let coordinator = HomeCoordinator(viewModel: viewModel)

        return HomeView(viewModel: viewModel, coordinator: coordinator)
    }
}
