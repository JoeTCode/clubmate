//
//  Settings.swift
//  Clubmate
//
//

import SwiftUI
import Combine

class Settings: ObservableObject {
    static let shared = Settings()
    // Default values for configurables
    @Published var numCourts = 2
    @Published var maxPlayersPerCourt = 4

}

struct SettingsView: View {
    var body: some View {
        VStack {
            Text("Settings")
            
        }
    }
}

#Preview {
    ContentView()
}
