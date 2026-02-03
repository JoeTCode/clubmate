//
//  Courts.swift
//  Clubmate
//
//

import SwiftUI

struct Courts: View {
    @ObservedObject var store = PlayerStore.shared
    let settings = Settings.shared
    
    struct Court: Identifiable {
        let id = UUID()
        var name: String
        var players: [PlayerStore.Player] = []
        var maxPlayers: Int
    }
    
    var computedCourts: [Court] {
        stride(from: 0, to: store.players.count, by: settings.maxPlayersPerCourt).map { index in
            let end = min(index + settings.maxPlayersPerCourt, store.players.count)
            let playersInCourt = Array(store.players[index..<end])
            
            return Court(
                name: "Court \((index / settings.maxPlayersPerCourt) + 1)",
                players: playersInCourt,
                maxPlayers: settings.maxPlayersPerCourt
            )
        }
    }
    
    var body: some View {
        VStack {
            ForEach(computedCourts) { court in
                Text(court.name)
                VStack {
//                    HStack {
//                        Text(court.players[0].name)
//                            .padding()
//                        Text("Player 2")
//                    }
//                    .padding()
                    
//                    HStack {
//                        Text("Player 3")
//                            .padding()
//                        Text("Player 4")
//                    }
                    
                    ZStack(alignment: .topLeading) {
                        Rectangle()
                            .fill(Color.green)
                            .frame(width: 300, height: 600)
                            .overlay(
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(height: 10),
                                alignment: .center
                            )
                        
                        
                        VStack {
                            HStack {
                                Text("Player 1")
                                Spacer()
                                Text("Player 2")
                            }
                            .padding(60)
                            
                            Spacer()
                            
                            HStack {
                                Text("Player 3")
                                Spacer()
                                Text("Player 4")
                            }
                            .padding(60)
                        }
                    }
                }
                .frame(width: 300, height: 600)
                .background(Rectangle().fill(Color.green))
                
            }
            
        }
    }
}
