//
//  NewsSourcesInteractor.swift
//  News
//
//  Created by Tubagus Adhitya Permana on 11/08/23.
//

import Foundation
import Combine

protocol NewsSourcesUseCase {
    func getNewsSources(page: Int) -> AnyPublisher<[NewsSourceModel], Error>
    func getCategory() -> String
}
class NewsSourcesInteractor: NewsSourcesUseCase {
    private let repository: NewsRepositoryProtocol
    private let category: String
    required init(repository: NewsRepositoryProtocol, category: String) {
        self.repository = repository
        self.category = category
    }
    func getNewsSources(page: Int) -> AnyPublisher<[NewsSourceModel], Error> {
        return repository.getNewsSources(category: category, page: page)
    }
    func getCategory() -> String {
        return category
    }
}
