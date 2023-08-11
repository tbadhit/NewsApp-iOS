//
//  NewsArticlesView.swift
//  News
//
//  Created by Tubagus Adhitya Permana on 10/08/23.
//

import SwiftUI

struct NewsArticlesView: View {
    @ObservedObject var presenter: NewsArticlesPresenter
    var body: some View {
        ZStack {
            if presenter.loadingState {
                ProgressView("Loading...")
            } else {
                if presenter.newsArticles.isEmpty {
                    Text("There is no articles")
                } else {
                    List {
                        ForEach(self.presenter.filteredNewsArticles, id: \.title) { article in
                            self.presenter.linkBuilder(forUrl: article.url) {
                                Text(article.title)
                            }
                            .onAppear {
                                if self.presenter.isNearLastItem(article) && !self.presenter.loadingMoreState {
                                    self.presenter.loadMoreNewsArticles()
                                }
                            }
                        }
                        if self.presenter.loadingMoreState {
                            loadingRow
                        }
                    }
                }
            }
        }
        .searchable(text: $presenter.searchQuery, placement: .navigationBarDrawer(displayMode: .always))
        .navigationTitle("News Articles")
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.inset)
        .onAppear {
            self.presenter.getNewsArticles()
        }
        .alert(presenter.message, isPresented: $presenter.isNotSuccess) {
            Button("OK", role: .cancel) { }
        }
    }
}

extension NewsArticlesView {
    private var loadingRow: some View {
            HStack {
                Spacer()
                ProgressView()
                    .padding()
                Spacer()
            }
        }
}
