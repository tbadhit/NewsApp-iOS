//
//  RemoteDataSource.swift
//  News
//
//  Created by Tubagus Adhitya Permana on 11/08/23.
//

import Foundation
import Combine
import Alamofire

protocol RemoteDataSourceProtocol: AnyObject {
    func getNewsCategories() -> AnyPublisher<[SourceResponse], Error>
    func getNewsSources(category: String, page: Int) -> AnyPublisher<[SourceResponse], Error>
    func getNewsArticles(source: String, page: Int) -> AnyPublisher<[ArticleResponse], Error>
}
final class RemoteDataSource: NSObject {
    private override init() {}
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
}
extension RemoteDataSource: RemoteDataSourceProtocol {
    func getNewsCategories() -> AnyPublisher<[SourceResponse], Error> {
        return Future<[SourceResponse], Error> { completion in
            if let url = URL(string: Endpoints.Gets.categories.url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: SourcesResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.sources))
                        case .failure(let error):
                            print("\(error.localizedDescription)")
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    func getNewsSources(category: String, page: Int) -> AnyPublisher<[SourceResponse], Error> {
        return Future<[SourceResponse], Error> { completion in
            if let url = URL(string: Endpoints.Gets.sources(category, page).url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: SourcesResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.sources))
                        case .failure(let error):
                            print("\(error.localizedDescription)")
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    func getNewsArticles(source: String, page: Int) -> AnyPublisher<[ArticleResponse], Error> {
        return Future<[ArticleResponse], Error> { completion in
            if let url = URL(string: Endpoints.Gets.articles(source, page).url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: ArticlesResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.articles))
                        case .failure(let error):
                            print("\(error.localizedDescription)")
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}
