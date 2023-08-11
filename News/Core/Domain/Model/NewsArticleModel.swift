//
//  NewsArticleModel.swift
//  News
//
//  Created by Tubagus Adhitya Permana on 11/08/23.
//

import Foundation

struct NewsArticleModel: Codable {
    let author, title, description: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    let content: String
}
