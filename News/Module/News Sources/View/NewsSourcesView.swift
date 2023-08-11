//
//  NewsSourcesView.swift
//  News
//
//  Created by Tubagus Adhitya Permana on 10/08/23.
//

import SwiftUI

struct NewsSourcesView: View {
    @ObservedObject var presenter: NewsSourcesPresenter
    var body: some View {
        ZStack {
            if presenter.loadingState {
                ProgressView("Loading...")
            } else {
                if presenter.newsSources.isEmpty {
                    Text("There is no sources")
                } else {
                    List {
                        ForEach(presenter.filteredNewsSources, id: \.id) { source in
                            self.presenter.linkBuilder(forSource: source.id) {
                                Text(source.name)
                            }
                            .onAppear {
                                if self.presenter.isNearLastItem(source) && !self.presenter.loadingMoreState {
                                    self.presenter.loadMoreNewsSources()
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
        .navigationTitle("News Sources (\(presenter.category))")
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.inset)
        .onAppear {
            self.presenter.getNewsSources()
        }
        .alert(presenter.message, isPresented: $presenter.isNotSuccess) {
            Button("OK", role: .cancel) { }
        }
    }
}

extension NewsSourcesView {
    private var loadingRow: some View {
            HStack {
                Spacer()
                ProgressView()
                    .padding()
                Spacer()
            }
        }
}
