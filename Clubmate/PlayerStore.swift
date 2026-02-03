//
//  PlayerStore.swift
//  Clubmate
//
//

import Foundation
import Combine

class PlayerStore: ObservableObject {
    static let shared = PlayerStore()
    
    @Published var players: [Player] = []
    @Published var duplicateScanAlert = false
    
    struct Player: Identifiable, Equatable {
        let id = UUID()
        var name: String
    }
    
    func addPlayer(name: String) {
        if (!self.contains(name: name)) {
            players.append(Player(name: name))
        } else {
            duplicateScanAlert = true
        }
    }
    
    func contains(name: String) -> Bool {
        return players.contains(where: { $0.name == name })
    }
    
    func totalPlayers() -> Int {
        return players.count
    }
    
    
}
