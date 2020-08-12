//
//  SettingsManager.swift
//  FeedMeNews
//
//  Created by Steve Galbraith on 8/11/20.
//

import Foundation

final class SettingsManager {
    static var shared = SettingsManager()
    private init() {}

    var maxResults = 25
    var language = Locale.current.languageCode ?? "en"
}
