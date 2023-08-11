//
//  NewsMapper.swift
//  News
//
//  Created by Tubagus Adhitya Permana on 11/08/23.
//

import Foundation

final class NewsMapper {
    static func mapNewsCategoryResponseToDomain(
        input newsCategoryResponse: [SourceResponse]
    ) -> [String] {
        let categoriesSet = Set(newsCategoryResponse.map {
            $0.category ?? ""
        })
        let categories: [String] = Array(categoriesSet)
        return categories
    }
    static func mapNewsSourceResponseToDomain(
        input newsSourceResponse: [SourceResponse]
    ) -> [NewsSourceModel] {
        return newsSourceResponse.map { source in
            return NewsSourceModel(
                id: source.id ?? "0",
                name: source.name ?? "No name",
                description: source.description ?? "No description",
                url: source.url ?? "https://internettepat.telkomsel.com/dns?orig_url=http://id.id",
                category: source.category ?? "No category",
                language: source.language ?? "No language",
                country: source.country ?? "No country")
        }
    }
    static func mapNewsArticleResponseToDomain(
        input newsArticleResponse: [ArticleResponse]
    ) -> [NewsArticleModel] {
        return newsArticleResponse.map { article in
            return NewsArticleModel(
                author: article.author ?? "No Author",
                title: article.title ?? "No title",
                description: article.description ?? "No description",
                url: article.url ?? "https://internettepat.telkomsel.com/dns?orig_url=http://id.id",
                urlToImage: article.urlToImage ?? "https://www.kliknusae.com/img/404.jpg",
                publishedAt: article.publishedAt ?? "No data",
                content: article.content ?? "No content")
        }
    }
}
