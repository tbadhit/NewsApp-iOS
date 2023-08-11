//
//  HomeInteractor.swift
//  News
//
//  Created by Tubagus Adhitya Permana on 11/08/23.
//

import Foundation
import Combine

protocol HomeUseCase {
    func getNewsCategories() -> AnyPublisher<[String], Error>
}
class HomeInteractor: HomeUseCase {
    private let repository: NewsRepositoryProtocol
    required init(repository: NewsRepositoryProtocol) {
        self.repository = repository
    }
    func getNewsCategories() -> AnyPublisher<[String], Error> {
        return repository.getNewsCategories()
    }
}
