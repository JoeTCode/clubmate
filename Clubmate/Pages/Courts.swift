//
//  Courts.swift
//  Clubmate
//
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var draggablePlayer: UTType { UTType(exportedAs: "com.clubmate.draggablePlayer") }
}

struct CourtsView: View {
    @ObservedObject var store = PlayerStore.shared
    let settings = Settings.shared
    @State var compactView = true
    let missingPlayerPlaceholder = "None"
    
    struct Court: Identifiable {
        var id: UUID = UUID()
        var name: String
        var firstTeam : [DraggablePlayer] = []
        var secondTeam : [DraggablePlayer] = []
    }
    
    struct DraggablePlayer: Codable, Transferable {
        var id: UUID = UUID()
        var player: PlayerStore.Player
        static var transferRepresentation: some TransferRepresentation {
            CodableRepresentation(for: DraggablePlayer.self, contentType: .draggablePlayer)
        }
    }
    
    private func playerProvider(players: [DraggablePlayer], index: Int) -> String {
        return index < players.count ? players[index].player.name : missingPlayerPlaceholder
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
    
    @State var bench: [DraggablePlayer] = [
        DraggablePlayer(player: PlayerStore.Player(name: "Riccardo")),
        DraggablePlayer(player: PlayerStore.Player(name: "Desmond"))
    ]
    
    @State var testComputedCourts: [Court] = {
        let player1 = DraggablePlayer(player: PlayerStore.Player(name: "John"))
        let player2 = DraggablePlayer(player: PlayerStore.Player(name: "Tom"))
        let player3 = DraggablePlayer(player: PlayerStore.Player(name: "Paul"))
        let player4 = DraggablePlayer(player: PlayerStore.Player(name: "Rod"))
        let player5 = DraggablePlayer(player: PlayerStore.Player(name: "Keagan"))
        let player6 = DraggablePlayer(player: PlayerStore.Player(name: "Jordan"))
        let player7 = DraggablePlayer(player: PlayerStore.Player(name: "Brady"))
        let player8 = DraggablePlayer(player: PlayerStore.Player(name: "Lindsay"))
        let player9 = DraggablePlayer(player: PlayerStore.Player(name: "Keagan"))
        let player10 = DraggablePlayer(player: PlayerStore.Player(name: "Jordan"))
        let player11 = DraggablePlayer(player: PlayerStore.Player(name: "Brady"))
        let player12 = DraggablePlayer(player: PlayerStore.Player(name: "Lindsay"))
        let player13 = DraggablePlayer(player: PlayerStore.Player(name: "Keagan"))
        let player14 = DraggablePlayer(player: PlayerStore.Player(name: "Jordan"))
        let player15 = DraggablePlayer(player: PlayerStore.Player(name: "Brady"))
        let player16 = DraggablePlayer(player: PlayerStore.Player(name: "Lindsay"))
        
        return [
            Court(
                name: "Court 1",
                firstTeam: [player1, player2],
                secondTeam: [player3, player4]
            ),
            Court(
                name: "Court 2",
                firstTeam: [player5, player6],
                secondTeam: [player7, player8]
            ),
            Court(
                name: "Court 3",
                firstTeam: [player9, player10],
                secondTeam: [player11, player12]
            ),
            Court(
                name: "Court 4",
                firstTeam: [player13, player14],
                secondTeam: [player15, player16]
            )
        ]
    }()
    
    func benchPlayer(movedPlayers: [DraggablePlayer]) {
        guard let draggablePlayer = movedPlayers.first else { return }
        
        // Remove player from court and bench
        for i in testComputedCourts.indices {
            testComputedCourts[i].firstTeam.removeAll { $0.player.id == draggablePlayer.player.id }
            testComputedCourts[i].secondTeam.removeAll { $0.player.id == draggablePlayer.player.id }
        }
        
        bench.removeAll { $0.player.id == draggablePlayer.player.id }
        
        bench.append(draggablePlayer)
    }
    
    func movePlayer(targetCourtId: UUID, isFirstTeam: Bool, movedPlayers: [DraggablePlayer]) {
        guard let draggablePlayer = movedPlayers.first else { return }
        
        // Remove player from court and bench
        for i in testComputedCourts.indices {
            testComputedCourts[i].firstTeam.removeAll { $0.player.id == draggablePlayer.player.id }
            testComputedCourts[i].secondTeam.removeAll { $0.player.id == draggablePlayer.player.id }
        }
        
        bench.removeAll { $0.player.id == draggablePlayer.player.id }

        
        // Add player to target court
        for i in testComputedCourts.indices {
            if (testComputedCourts[i].id == targetCourtId) {
                if (isFirstTeam) {
                    testComputedCourts[i].firstTeam.append(draggablePlayer)
                } else {
                    testComputedCourts[i].secondTeam.append(draggablePlayer)
                }
            }
        }
    }
    
    // Specify the min grid item size before wrapping
    let columns = [
        GridItem(.adaptive(minimum: 300)),
    ]
    
    var body: some View {
        VStack {
            Button(action: {
                compactView.toggle()
            }) {
                Image(systemName: compactView ? "square.grid.2x2" : "list.bullet")
            }
            
            if (compactView) {
                ScrollView {
                    LazyVGrid (columns: columns) {
                        ForEach($testComputedCourts) { $court in
                            // Court
                            VStack {
                                Text(court.name)
                                
                                // Teams
                                VStack {
                                    // First Team
                                    HStack {
                                        ForEach(court.firstTeam, id: \.self.player.id) { draggablePlayer in
                                            Text(draggablePlayer.player.name)
                                                .padding()
                                                .background(Color.init(white: 0.95))
                                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                                .draggable(draggablePlayer)
                                        }
                                    }
                                    .frame(width: 300, height: 70)
                                    .background(Color.black.opacity(0.001))
                                    .dropDestination(for: DraggablePlayer.self) { draggablePlayers, _ in
                                        movePlayer(targetCourtId: court.id, isFirstTeam: true, movedPlayers: draggablePlayers)
                                        return true
                                    }
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.blue, lineWidth: 1)
                                    )
                                    
                                    // Second team
                                    HStack {
                                        ForEach(court.secondTeam, id: \.self.player.id) { draggablePlayer in
                                            Text(draggablePlayer.player.name)
                                                .padding()
                                                .background(Color.blue)
                                                .foregroundStyle(Color.white)
                                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                                .draggable(draggablePlayer)
                                        }
                                    }
                                    .frame(width: 300, height: 70)
                                    .background(Color.init(white: 0.95))
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .dropDestination(for: DraggablePlayer.self) { draggablePlayers, _ in
                                        movePlayer(targetCourtId: court.id, isFirstTeam: false, movedPlayers: draggablePlayers)
                                        return true
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .frame(maxHeight: .infinity)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.init(white: 0.94), lineWidth: 2)
                            )
                        }
                    }
                }
                
                ScrollView {
                    LazyVGrid (columns: columns) {
                        ForEach(bench, id: \.self.player.id) { draggablePlayer in
                            Text(draggablePlayer.player.name)
                                .draggable(draggablePlayer)
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .background(Color.init(white: 0.92))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .dropDestination(for: DraggablePlayer.self) { draggablePlayers, _ in
                    benchPlayer(movedPlayers: draggablePlayers)
                    return true
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
                                            
                                            // First team
                                            HStack {
                                                Text(playerProvider(players: court.firstTeam, index: 0))
                                                    .frame(width: 80, height: 40)
                                                    .background(Color.init(white: 0.95))
                                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                                Spacer()
                                                Text(playerProvider(players: court.firstTeam, index: 1))
                                                    .frame(width: 80, height: 40)
                                                    .background(Color.init(white: 0.95))
                                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                            }
                                            .padding(100)
                                            
                                            Spacer()
                                            
                                            // Second team
                                            HStack {
                                                Text(playerProvider(players: court.secondTeam, index: 0))
                                                    .frame(width: 80, height: 40)
                                                    .background(Color.blue)
                                                    .foregroundStyle(Color.white)
                                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                                Spacer()
                                                Text(playerProvider(players: court.secondTeam, index: 1))
                                                    .frame(width: 80, height: 40)
                                                    .background(Color.blue)
                                                    .foregroundStyle(Color.white)
                                                    .clipShape(RoundedRectangle(cornerRadius: 12))
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
        .padding()
    }
}

#Preview {
    ContentView()
}
