//
//  NewsSourcesPresenter.swift
//  News
//
//  Created by Tubagus Adhitya Permana on 11/08/23.
//

import Combine
import SwiftUI

class NewsSourcesPresenter: ObservableObject {
    private let router = NewsSourcesRouter()
    @Published var loadingState: Bool = false
    @Published var loadingMoreState: Bool = false
    @Published var isNotSuccess: Bool = false
    @Published var message: String = ""
    @Published var category: String
    @Published var page: Int = 1
    @Published var searchQuery = ""
    @Published var newsSources: [NewsSourceModel] = []
    var filteredNewsSources: [NewsSourceModel] {
        if searchQuery.isEmpty {
            return newsSources
        } else {
            return newsSources.filter { source in
                source.name.localizedCaseInsensitiveContains(searchQuery)
            }
        }
    }
    private var cancellables: Set<AnyCancellable> = []
    private let newsSourcesUseCase: NewsSourcesUseCase
    init(newsSourcesUseCase: NewsSourcesUseCase) {
        self.newsSourcesUseCase = newsSourcesUseCase
        self.category = newsSourcesUseCase.getCategory()
    }
    func getNewsSources() {
        page = 1
        loadingState = true
        newsSourcesUseCase.getNewsSources(page: page)
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
            }, receiveValue: { newsSources in
                self.newsSources = newsSources
            })
            .store(in: &cancellables)
    }
    func loadMoreNewsSources() {
        loadingMoreState = true
        page += 1
        newsSourcesUseCase.getNewsSources(page: page)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.loadingMoreState = false
                case .failure:
                    self.loadingMoreState = false
                    print("Completion", completion)
                }
            }, receiveValue: { newsSources in
                self.newsSources.append(contentsOf: newsSources)
            })
            .store(in: &cancellables)
    }
    func isNearLastItem(_ item: NewsSourceModel) -> Bool {
            if let lastItem = filteredNewsSources.last {
                return item.id == lastItem.id
            }
            return false
        }
    func linkBuilder<Content: View>(
        forSource source: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink {
            router.makeNewsArticlesView(source: source)
        } label: {
            content()
        }

    }
}
