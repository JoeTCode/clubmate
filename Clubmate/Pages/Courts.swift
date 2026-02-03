//
//  COurts.swift
//  Clubmate
//
//

import SwiftUI

struct Courts: View {
    let players = PlayerStore.shared.players
    
    var body: some View {
        ForEach(players) { player in
            Text("Player: \(player)")
        }
    }
}
