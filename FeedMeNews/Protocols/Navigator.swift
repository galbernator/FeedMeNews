//
//  Navigator.swift
//  FeedMeNews
//
//  Created by Steve Galbraith on 8/13/20.
//

import SwiftUI

protocol Navigator {
    associatedtype Destination
    func view(for destination: Destination) -> AnyView
}

extension Navigator {
    func view(for destination: DefaultDestination) -> AnyView {
        fatalError("Implemetation of view(for:) needs to be implemented in the conforming class")
    }
}

enum DefaultDestination {
    case demo
}
