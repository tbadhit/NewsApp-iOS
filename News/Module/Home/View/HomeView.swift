//
//  ContentView.swift
//  News
//
//  Created by Tubagus Adhitya Permana on 10/08/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var presenter: HomePresenter
    var body: some View {
        NavigationView {
            ZStack {
                if presenter.loadingState {
                    ProgressView("Loading...")
                } else {
                    if presenter.newsCategories.isEmpty {
                        Text("There is no categories")
                    } else {
                        List(self.presenter.newsCategories, id: \.self) { category in
                            self.presenter.linkBuilder(forCategory: category) {
                                Text(category)
                            }

                        }
                    }
                }
            }
            .navigationTitle("News Categories")
            .listStyle(.inset)
            .onAppear {
                self.presenter.getNewsCategories()
            }
            .alert(presenter.message, isPresented: $presenter.isNotSuccess) {
                Button("OK", role: .cancel) { }
            }
        }
    }
}
