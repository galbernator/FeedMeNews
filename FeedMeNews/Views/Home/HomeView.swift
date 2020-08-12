//
//  HomeView.swift
//  FeedMeNews
//
//  Created by Steve Galbraith on 8/11/20.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    let coordinator: HomeCoordinator

    var body: some View {
        if viewModel.articles.isEmpty {
            Text("Loading your articles...")
        } else {
            List {
                ForEach(self.viewModel.articles, id: \.title) { article in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(article.title)
                            .font(.title)

                        Text(article.author)
                            .foregroundColor(.gray)
                            .opacity(0.6)
                    }
                }
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
