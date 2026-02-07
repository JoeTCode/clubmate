//
//  ContentView.swift
//  Clubmate
//
//

//import SwiftUI
//
//struct ContentView: View {
//    @State private var bench = ["Federer", "Nadal", "Djokovic"]
//    @State private var court: [String] = []
//
//    var body: some View {
//        VStack(spacing: 50) {
//            // SOURCE: The Bench
//            VStack {
//                Text("THE BENCH (Drag from here)")
//                    .font(.caption).bold()
//                HStack {
//                    ForEach(bench, id: \.self) { player in
//                        Text(player)
//                            .padding()
//                            .background(Color.blue.cornerRadius(8))
//                            .foregroundColor(.white)
//                            .draggable(player) // Enables dragging
//                    }
//                }
//            }
//            .frame(maxWidth: .infinity, minHeight: 100)
//            .background(Color.gray.opacity(0.1))
//            .dropDestination(for: String.self) { items, _ in
//                for item in items {
//                    if (!bench.contains(item)) {
//                        bench.append(item)
//                        court.removeAll { $0 == item }
//                    }
//                }
//                return true
//            }
//
//            // DESTINATION: The Court
//            VStack {
//                Text("THE COURT (Drop here)")
//                    .font(.caption).bold()
//                HStack {
//                    ForEach(court, id: \.self) { player in
//                        Text(player)
//                            .padding()
//                            .background(Color.green.cornerRadius(8))
//                            .foregroundColor(.white)
//                            .draggable(player)
//                    }
//                }
//            }
//            .frame(maxWidth: .infinity, minHeight: 150)
//            .background(Color.green.opacity(0.1))
//            // This is the "Capture" logic
//            .dropDestination(for: String.self) { items, _ in
//                for item in items {
//                    if !court.contains(item) {
//                        court.append(item)
//                        bench.removeAll { $0 == item }
//                    }
//                }
//                return true
//            }
//        }
//        .padding()
//    }
//}

import SwiftUI


struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                PlayerListView()
            }
            .tabItem {
                Label("Players", systemImage: "person.3.fill")
            }
            NavigationView {
                CourtsView()
            }
            .tabItem {
                Label("Courts", systemImage: "tennisball.fill")
            }
            NavigationView {
                SettingsView()
            }
            .tabItem {
                Label("Settings", systemImage: "gearshape")
            }
            
        }
    }
}



#Preview {
    ContentView()
}
