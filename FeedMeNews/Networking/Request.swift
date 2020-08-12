//
//  Request.swift
//  FeedMeNews
//
//  Created by Steve Galbraith on 8/11/20.
//

import Foundation

final class RequestFormatter {
    static var shared = RequestFormatter()
    private init() {}

    let isoFormatter = ISO8601DateFormatter()
}

enum Request {
    private enum Constants {
        static let apiKey = "" // YOUR NEWSAPI.ORG API KEY
    }

    case headlines(page: Int = 1, category: String? = nil, country: String? = nil, sources: [String]? = nil, query: String? = nil)
    case everything(page: Int = 1, query: String? = nil, titleContains: String? = nil, dates: (from: Date, to: Date)? = nil, domains: [String]? = nil)
    case sources(page: Int = 1)

    /// The `URLRequest` object that should be passed to the `URLSession`
    var urlRequest: URLRequest {
        let urlPath = [baseURLString, apiVersion, path].joined(separator: "/")
        let params = parameters.map { "\($0)=\($1)" }.joined(separator: ",")
        let urlString = [urlPath, params].joined(separator: "&")
        guard let url = URL(string: urlString) else {
            fatalError("Unable to create url from \(urlString)")
        }

        var request = URLRequest(url: url)
        request.method = method
        return request
    }

    private var baseURLString: String {
        switch self {
        case .headlines, .everything, .sources:
            return "https://newsapi.org"
        }
    }

    private var apiVersion: String {
        switch self {
        case .headlines, .everything, .sources:
            return "v2"
        }
    }

    private var path: String {
        switch self {
        case .headlines:
            return "headlines"
        case .everything:
            return "everything"
        case .sources:
            return "sources"
        }
    }

    private var method: URLRequest.HTTPMethod {
        switch self {
        case .headlines, .everything, .sources:
            return .get
        }
    }

    private var parameters: [String : Any] {
        var params = [String : Any]()
        switch self {
        case .headlines(let page, let category, let country, let sources, let query):
            if let sources = sources {
                params["sources"] = sources
            } else {
                if let category = category {
                    params["category"] = category
                }

                if let country = country {
                    params["country"] = country
                }
            }

            if let query = query {
                params["q"] = query
            }

            params["page"] = page

        case .everything(let page, let query, let titleContains, let dates, let domains):
            if let encodedQuery = query?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                params["q"] = encodedQuery
            }

            if let encodedTitleQuery = titleContains?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                params["qInTitle"] = encodedTitleQuery
            }

            if let dates = dates {
                let formatter = RequestFormatter.shared.isoFormatter
                params["from"] = formatter.string(from: dates.from)
                params["to"] = formatter.string(from: dates.to)
            }

            if let domains = domains {
                params["domains"] = domains.joined(separator: ",")
            }

            params["page"] = page
        case .sources:
            // TODO: Finish adding the parameter constructor for the sources request
            break
        }

        params["apiKey"] = Constants.apiKey
        params["language"] = language
        params["pageSize"] = numberOfResults
        return params
    }

    private var numberOfResults: Int {
        SettingsManager.shared.maxResults
    }

    private var language: String? {
        SettingsManager.shared.language
    }
}
