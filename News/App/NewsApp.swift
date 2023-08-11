//
//  NewsApp.swift
//  News
//
//  Created by Tubagus Adhitya Permana on 10/08/23.
//

import SwiftUI

@main
struct NewsApp: App {
    let homePresenter = HomePresenter(homeUseCase: Injection.init().provideHome())
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(homePresenter)
        }
    }
}
