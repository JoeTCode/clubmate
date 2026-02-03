//
//  Players.swift
//  Clubmate
//
//

import Foundation

final class Players {
    static let shared = Players()
    private var idToPlayer = [Int: String]()
    
    struct Player: Codable {
        let id: Int
        let name: String
    }
    
    private init() {
        let url = Bundle.main.url(forResource: "players", withExtension: "json")!
        let data = try! Data.init(contentsOf: url)
        
        do {
            let players = try JSONDecoder().decode([Player].self, from: data)
            for player in players {
                self.idToPlayer[player.id] = player.name
            }
        } catch {
            print("Error reading players file: \(error)")
        }
    }
    
    // Optionally returns string (else nil) in case id does not exist in dict
    func name(id: Int) -> String? {
        return idToPlayer[id]
    }
}
