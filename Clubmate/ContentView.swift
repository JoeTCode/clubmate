//
//  ContentView.swift
//  Clubmate
//
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            NavigationView {
                PlayerList()
            }
            .tabItem {
                Label("Players", systemImage: "person.3.fill")
            }
            NavigationView {
                Text("Court Info")
            }
            .tabItem {
                Label("Courts", systemImage: "tennisball.fill")
            }
        }
    }
}

#Preview {
    ContentView()
}
