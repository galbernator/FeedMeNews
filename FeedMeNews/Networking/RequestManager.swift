//
//  RequestManager.swift
//  FeedMeNews
//
//  Created by Steve Galbraith on 8/11/20.
//

import Foundation
import Combine

enum NetworkRequestError: Error {
    case invalidStatusCode(_ statusCode: Int)
    case error(Error)

    var error: Error {
        switch self {
        case .invalidStatusCode:
            return self
        case .error(let error):
            return error
        }
    }
}

final class RequestManager {

    /// A generic function that takes in a `Request` and will return a `Publisher` of the `Decodable` generic type.
    /// - Parameter request: A `Request` object
    /// - Returns: A `Publisher` that has an `Output` type that conforms to `Decodable` and a `NetworkRequestError` `Failure` type
    static func send<T: Decodable>(_ request: Request) -> AnyPublisher<T, NetworkRequestError> {
        URLSession.shared.dataTaskPublisher(for: request.urlRequest)
            .tryMap { result in
                if let urlResponse = result.response as? HTTPURLResponse, !(200...299).contains(urlResponse.statusCode) {
                    throw NetworkRequestError.invalidStatusCode(urlResponse.statusCode)
                }

                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                return try decoder.decode(T.self, from: result.data)
            }
            .mapError { NetworkRequestError.error($0) }
            .eraseToAnyPublisher()
    }
}
