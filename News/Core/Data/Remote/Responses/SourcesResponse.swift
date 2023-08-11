//
//  SourcesResponse.swift
//  News
//
//  Created by Tubagus Adhitya Permana on 11/08/23.
//

import Foundation

struct SourcesResponse: Codable {
    let status: String
    let sources: [SourceResponse]
}

struct SourceResponse: Codable {
    let id, name, description: String?
    let url: String?
    let category: String?
    let language, country: String?
}
