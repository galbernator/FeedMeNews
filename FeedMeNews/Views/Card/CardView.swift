//
//  CardView.swift
//  FeedMeNews
//
//  Created by Steve Galbraith on 8/13/20.
//

import SwiftUI

struct CardView: View {
    @Environment(\.imageCache) var cache: ImageCache
    @ObservedObject var viewModel: CardViewModel
    let coordinator: CardCoordinator

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let imageURL = viewModel.imageURL {
                AsyncImage(
                    url: imageURL,
                    cache: self.cache,
                    placeholder: Text("Loading ..."),
                    configuration: { $0.resizable() }
                )
                .aspectRatio(contentMode: .fit)
            }

            Text(viewModel.title)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)

            HStack {
                VStack(alignment: .leading) {
                    if let author = viewModel.author {
                        Text("by \(author)")
                    }
                    Text(viewModel.publishedAtText)
                }
                .font(.caption)
                Text(viewModel.sourceName)
                Spacer()

            }
            .padding(.horizontal, 10)
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 13, style: .circular)
                .strokeBorder(Color.gray, lineWidth: 1.0, antialiased: true)
        )
        .padding(.horizontal, 5)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let article = Article.example
        let viewModel = CardViewModel(for: article)
        let coordinator = CardCoordinator(viewModel: viewModel)

        return CardView(viewModel: viewModel, coordinator: coordinator)
    }
}
