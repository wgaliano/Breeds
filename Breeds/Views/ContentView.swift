//
//  ContentView.swift
//  Breeds
//
//  Created by Walter Galiano on 27/03/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RandomDogView()
                .tabItem {
                    Label("Pick the dog", systemImage: "pawprint")
                }
            
            FindBreedView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
