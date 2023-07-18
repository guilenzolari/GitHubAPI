//
//  ContentView.swift
//  GitHub API
//
//  Created by Guilherme Ferreira Lenzolari on 17/07/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var user: GitHubUser?
    
    var body: some View {
        
        TabView {
            AboutMeView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Me")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

