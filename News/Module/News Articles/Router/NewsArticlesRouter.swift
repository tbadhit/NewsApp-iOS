//
//  NewsArticlesRouter.swift
//  News
//
//  Created by Tubagus Adhitya Permana on 11/08/23.
//

import SwiftUI

class NewsArticlesRouter {
    func makeDetailArticleView(url: String) -> some View {
        return DetailArticleView(url: url)
    }
}
