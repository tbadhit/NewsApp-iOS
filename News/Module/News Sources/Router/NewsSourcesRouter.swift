//
//  NewsSourcesRouter.swift
//  News
//
//  Created by Tubagus Adhitya Permana on 11/08/23.
//

import SwiftUI

class NewsSourcesRouter {
    func makeNewsArticlesView(source: String) -> some View {
        let newsArticlesUseCase = Injection.init().provideNewsArticles(source: source)
        let presenter = NewsArticlesPresenter(newsArticlesUseCase: newsArticlesUseCase)
        return NewsArticlesView(presenter: presenter)
    }
}
