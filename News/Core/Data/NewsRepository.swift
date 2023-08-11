//
//  NewsRepository.swift
//  News
//
//  Created by Tubagus Adhitya Permana on 11/08/23.
//

import Foundation
import Combine

protocol NewsRepositoryProtocol {
    func getNewsCategories() -> AnyPublisher<[String], Error>
    func getNewsSources(category: String, page: Int) -> AnyPublisher<[NewsSourceModel], Error>
    func getNewsArticles(source: String, page: Int) -> AnyPublisher<[NewsArticleModel], Error>
}
final class NewsRepository: NSObject {
    typealias NewsInstance = (RemoteDataSource) -> NewsRepository
    fileprivate let remote: RemoteDataSource
    private init(remote: RemoteDataSource) {
        self.remote = remote
    }
    static let sharedInstance: NewsInstance = { remoteRepo in
        return NewsRepository(remote: remoteRepo)
    }
}
extension NewsRepository: NewsRepositoryProtocol {
    func getNewsCategories() -> AnyPublisher<[String], Error> {
        return self.remote.getNewsCategories()
            .map {
                NewsMapper.mapNewsCategoryResponseToDomain(input: $0)
            }
            .eraseToAnyPublisher()
    }
    func getNewsSources(category: String, page: Int) -> AnyPublisher<[NewsSourceModel], Error> {
        return self.remote.getNewsSources(category: category, page: page)
            .map {
                NewsMapper.mapNewsSourceResponseToDomain(input: $0)
            }
            .eraseToAnyPublisher()
    }
    func getNewsArticles(source: String, page: Int) -> AnyPublisher<[NewsArticleModel], Error> {
        return self.remote.getNewsArticles(source: source, page: page)
            .map {
                NewsMapper.mapNewsArticleResponseToDomain(input: $0)
            }
            .eraseToAnyPublisher()
    }
}
