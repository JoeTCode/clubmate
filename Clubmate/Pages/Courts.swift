//
//  Courts.swift
//  Clubmate
//
//

import SwiftUI

struct Courts: View {
    @ObservedObject var store = PlayerStore.shared
    let settings = Settings.shared
    @State var compactView = true
    let missingPlayerPlaceholder = "None"
    
    struct Court: Identifiable {
        let id = UUID()
        var name: String
        var players: [PlayerStore.Player] = []
        var maxPlayers: Int
    }
    
    private func playerProvider(players: [PlayerStore.Player], index: Int) -> String {
        return index < players.count ? players[index].name : missingPlayerPlaceholder
    }
    
//    var computedCourts: [Court] {
//        stride(from: 0, to: store.players.count, by: settings.maxPlayersPerCourt).map { index in
//            let end = min(index + settings.maxPlayersPerCourt, store.players.count)
//            let playersInCourt = Array(store.players[index..<end])
//            
//            return Court(
//                name: "Court \((index / settings.maxPlayersPerCourt) + 1)",
//                players: playersInCourt,
//                maxPlayers: settings.maxPlayersPerCourt
//            )
//        }
//    }
    
    var testComputedCourts =
    [
        Court(name: "Court 1", players: [PlayerStore.Player(name: "John"), PlayerStore.Player(name: "Tom"), PlayerStore.Player(name: "Paul"), PlayerStore.Player(name: "Rod")], maxPlayers: 4),
        Court(name: "Court 2", players: [PlayerStore.Player(name: "Keagan"), PlayerStore.Player(name: "Jordan"), PlayerStore.Player(name: "Brady"), PlayerStore.Player(name: "Lindsay")], maxPlayers: 4)
    ]
    
    
    var body: some View {
        VStack {
            Button(action: {
                compactView.toggle()
            }) {
                Image(systemName: compactView ? "square.grid.2x2" : "list.bullet")
            }
            
            if (compactView) {
                HStack {
                    ForEach(testComputedCourts) { court in
                        VStack {
                            Text(court.name)
                            
                            VStack {
                                Text(playerProvider(players: court.players, index: 0))
                                Text(playerProvider(players: court.players, index: 1))
                                Text(playerProvider(players: court.players, index: 2))
                                Text(playerProvider(players: court.players, index: 3))
                            }
                        }
                    }
                }
            }
            
            else {
                ScrollView {
                    ForEach(testComputedCourts) { court in
                        VStack {
                            Text(court.name)
                            
                            ZStack {
                                Rectangle()
                                    .fill(Color.white)
                                ZStack {
                                    Rectangle()
                                        .fill(Color.green)
                                    VerticalTennisCourtLines()
                                        .stroke(Color.white, lineWidth: 2)
                                }
                                // Court size
                                .frame(width: 250, height: 450)
                                .border(Color.init(white: 0.9), width: 2)
                                VerticalTennisCourtNetcord()
                                    .fill(Color.init(white:0.9))
                                VerticalTennisCourtNetBottom()
                                VerticalTennisCourtNetPosts()
                                    .overlay {
                                        VStack{
                                            HStack {
                                                Text(playerProvider(players: court.players, index: 0))
                                                Spacer()
                                                Text(playerProvider(players: court.players, index: 1))
                                            }
                                            .padding(100)
                                            
                                            Spacer()
                                            
                                            HStack {
                                                Text(playerProvider(players: court.players, index: 3))
                                                Spacer()
                                                Text(playerProvider(players: court.players, index: 4))
                                            }
                                            .padding(100)
                                        }
                                    }
                            }
                            // Court background size
                            .frame(width: 340, height: 450)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}
