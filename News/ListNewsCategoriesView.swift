//
//  ContentView.swift
//  News
//
//  Created by Tubagus Adhitya Permana on 10/08/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            List(["C1", "C2", "C3"], id: \.self) { category in
                NavigationLink {
                    NewsSourcesView()
                } label: {
                    Text(category)
                }

            }
            .navigationTitle("News Categories")
            .listStyle(.inset)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
