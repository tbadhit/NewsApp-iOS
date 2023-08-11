//
//  NewsArticlesPresenter.swift
//  News
//
//  Created by Tubagus Adhitya Permana on 11/08/23.
//

import SwiftUI
import Combine

class NewsArticlesPresenter: ObservableObject {
    private let router = NewsArticlesRouter()
    @Published var loadingState: Bool = false
    @Published var source: String
    @Published var loadingMoreState: Bool = false
    @Published var isNotSuccess: Bool = false
    @Published var message: String = ""
    @Published var page: Int = 1
    @Published var searchQuery = ""
    @Published var newsArticles: [NewsArticleModel] = []
    var filteredNewsArticles: [NewsArticleModel] {
        if searchQuery.isEmpty {
            return newsArticles
        } else {
            return newsArticles.filter { article in
                article.title.localizedCaseInsensitiveContains(searchQuery)
            }
        }
    }
    private var cancellables: Set<AnyCancellable> = []
    private let newsArticlesUseCase: NewsArticlesUseCase
    init(newsArticlesUseCase: NewsArticlesUseCase) {
        self.newsArticlesUseCase = newsArticlesUseCase
        self.source = newsArticlesUseCase.getSource()
    }
    func getNewsArticles() {
        page = 1
        loadingState = true
        newsArticlesUseCase.getNewsArticles(page: page)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isNotSuccess = false
                    self.loadingState = false
                case .failure(let error):
                    self.isNotSuccess = true
                    self.loadingState = false
                    self.message = error.localizedDescription
                    print("Completion", completion)
                }
            }, receiveValue: { newsArticles in
                self.newsArticles = newsArticles
            })
            .store(in: &cancellables)
    }
    func loadMoreNewsArticles() {
        loadingMoreState = true
        page += 1
        newsArticlesUseCase.getNewsArticles(page: page)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isNotSuccess = false
                    self.loadingMoreState = false
                case .failure:
                    self.isNotSuccess = true
                    self.loadingMoreState = false
                    print("Completion", completion)
                }
            }, receiveValue: { newsArticles in
                self.newsArticles.append(contentsOf: newsArticles)
            })
            .store(in: &cancellables)
    }
    func isNearLastItem(_ item: NewsArticleModel) -> Bool {
            if let lastItem = filteredNewsArticles.last {
                return item.title == lastItem.title
            }
            return false
        }
    func linkBuilder<Content: View>(
        forUrl url: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink {
            router.makeDetailArticleView(url: url)
        } label: {
            content()
        }

    }
}
