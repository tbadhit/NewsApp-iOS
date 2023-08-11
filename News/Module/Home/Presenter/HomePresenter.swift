//
//  HomePresenter.swift
//  News
//
//  Created by Tubagus Adhitya Permana on 11/08/23.
//

import SwiftUI
import Combine

class HomePresenter: ObservableObject {
    private let router = HomeRouter()
    private let homeUseCase: HomeUseCase
    private var cancellables: Set<AnyCancellable> = []
    @Published var newsCategories: [String] = []
    @Published var loadingState: Bool = false
    @Published var isNotSuccess: Bool = false
    @Published var message: String = ""
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    func getNewsCategories() {
        loadingState = true
        homeUseCase.getNewsCategories()
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
            }, receiveValue: { newsCategories in
                self.newsCategories = newsCategories
            })
            .store(in: &cancellables)
    }
    func linkBuilder<Content: View>(
        forCategory category: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink {
            router.makeNewsSourcesView(category: category)
        } label: {
            content()
        }

    }
}
