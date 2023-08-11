//
//  NewsArticlesInteractor.swift
//  News
//
//  Created by Tubagus Adhitya Permana on 11/08/23.
//

import Foundation
import Combine

protocol NewsArticlesUseCase {
    func getNewsArticles(page: Int) -> AnyPublisher<[NewsArticleModel], Error>
    func getSource() -> String
}
class NewsArticlesInteractor: NewsArticlesUseCase {
    private let repository: NewsRepositoryProtocol
    private let source: String
    required init(repository: NewsRepositoryProtocol, source: String) {
        self.repository = repository
        self.source = source
    }
    func getNewsArticles(page: Int) -> AnyPublisher<[NewsArticleModel], Error> {
        return repository.getNewsArticles(source: source, page: page)
    }
    func getSource() -> String {
        return source
    }
}
