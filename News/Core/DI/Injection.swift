//
//  Injection.swift
//  News
//
//  Created by Tubagus Adhitya Permana on 11/08/23.
//

import Foundation

final class Injection: NSObject {
    private func provideRepository() -> NewsRepositoryProtocol {
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        return NewsRepository.sharedInstance(remote)
    }
    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    func provideNewsSources(category: String) -> NewsSourcesUseCase {
        let repository = provideRepository()
        return NewsSourcesInteractor(repository: repository, category: category)
    }
    func provideNewsArticles(source: String) -> NewsArticlesUseCase {
        let repository = provideRepository()
        return NewsArticlesInteractor(repository: repository, source: source)
    }
}
