//
//  Coordinator.swift
//  FeedMeNews
//
//  Created by Steve Galbraith on 8/11/20.
//

import SwiftUI

protocol Coordinator {
    func start() -> AnyView
    //TODO: Add deeplinking ability
}
