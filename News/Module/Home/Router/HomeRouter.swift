//
//  HomeRouter.swift
//  News
//
//  Created by Tubagus Adhitya Permana on 11/08/23.
//

import SwiftUI

class HomeRouter {
    func makeNewsSourcesView(category: String) -> some View {
        let newsSourcesUseCase = Injection.init().provideNewsSources(category: category)
        let presenter = NewsSourcesPresenter(newsSourcesUseCase: newsSourcesUseCase)
        return NewsSourcesView(presenter: presenter)
    }
}
