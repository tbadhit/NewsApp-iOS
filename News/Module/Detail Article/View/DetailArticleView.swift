//
//  DetailArticleView.swift
//  News
//
//  Created by Tubagus Adhitya Permana on 10/08/23.
//

import SwiftUI

struct DetailArticleView: View {
    let url: String
    init(url: String) {
        self.url = url
    }
    @State private var isLoading = true
    var body: some View {
        VStack {
           Webview(url: URL(string: url)!)
        }
    }
}
