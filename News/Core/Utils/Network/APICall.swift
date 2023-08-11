//
//  APICall.swift
//  News
//
//  Created by Tubagus Adhitya Permana on 11/08/23.
//

import Foundation

struct API {
    static let baseURL = "https://newsapi.org/v2/"
    static let key =  "710dddb76ccc4a0d8a5474fbaa3feeaf" // "7558fd63ad6b4008a0aceeedb8f27002"
}
protocol Endpoint {
    var url: String { get }
}
enum Endpoints {
    enum Gets: Endpoint {
        case categories
        case sources(String, Int)
        case articles(String, Int)
        public var url: String {
            switch self {
            case .categories:
                return "\(API.baseURL)sources?apiKey=\(API.key)"
            case let .sources(category, page):
                return "\(API.baseURL)sources?apiKey=\(API.key)&category=\(category)&page=\(page)"
            case let .articles(sources, page):
                return "\(API.baseURL)top-headlines?apiKey=\(API.key)&sources=\(sources)&page=\(page)"
            }
        }
    }
}
