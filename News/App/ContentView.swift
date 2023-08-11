//
//  ContentView.swift
//  News
//
//  Created by Tubagus Adhitya Permana on 11/08/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var presenter: HomePresenter
    var body: some View {
        HomeView(presenter: presenter)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
