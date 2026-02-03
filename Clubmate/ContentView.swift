//
//  ContentView.swift
//  Clubmate
//
//

import SwiftUI

struct ContentView: View {
    @StateObject private var nfcController = NFCController()
    @StateObject private var playerStore = PlayerStore.shared
    @FocusState private var scanButtonFocused: Bool
    @FocusState private var editListFocused: Bool
    @State private var enableRowEdit = false
    @State private var customPlayer = ""
    
    struct Player: Identifiable {
        let id = UUID()
        var name: String
    }
    
    func deletePlayer(at offsets: IndexSet) {
        self.playerStore.players.remove(atOffsets: offsets)
    }
    
    func addPlayer(name: String) {
        let trimmed = customPlayer.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty { return }
        self.playerStore.addPlayer(name: trimmed)
        customPlayer = ""
    }
    
    var body: some View {
        NavigationStack {
            NavigationLink {
                Text("Welcome!")
            } label: {
                Text("Courts")
            }
            NavigationLink {
                Text("")
            } label: {
                Text("")
            }
            
            VStack {
                HStack {
                    Text("Players: \(self.playerStore.totalPlayers())")
                    Spacer()
                    if (self.playerStore.totalPlayers() > 0) {
                        if (enableRowEdit) {
                            Button("Done") {
                                enableRowEdit = false
                            }
                        } else {
                            Button("Edit") {
                                enableRowEdit = true
                            }
                        }
                    }
                }
                if (self.playerStore.totalPlayers() == 0) {
                    VStack {
                        Text("No players found")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .border(Color.init(white: 0.95), width: 2)
                    .cornerRadius(15)
                }
                else {
                    List {
                        ForEach($playerStore.players) { $player in
                            if (!enableRowEdit) {
                                Text(player.name)
                                    .font(.system(size: 24))
                                    .listRowBackground(Color.init(white: 0.95))
                            }
                            else {
                                TextField("", text: $player.name)
                                    .focused($editListFocused)
                                    .font(.system(size: 24))
                                    .listRowBackground(Color.init(white: 0.95))
                            }
                        }
                        .onDelete(perform: deletePlayer)
                    }
                    .toolbar {
                        if (editListFocused) {
                            ToolbarItem(placement: .keyboard) {
                                Button("Done") {
                                    editListFocused = false
                                    enableRowEdit = false
                                }
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .border(Color.init(white: 0.95), width: 2)
                }
                
                VStack {
                    HStack {
                        TextField("", text: $customPlayer, prompt: Text("Manually add player").foregroundStyle(Color.gray))
                            .focused($scanButtonFocused)
                            // Adds a button to toolbar that dismisses keyboard (user can optionally press inbuilt return button)
                            .toolbar {
                                if (scanButtonFocused) {
                                    ToolbarItem(placement: .keyboard) {
                                        Button("Done") {
                                            scanButtonFocused = false
                                        }
                                    }
                                }
                            }
                        
    
                        Button (action: {
                            addPlayer(name: customPlayer)
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                    .padding()
                    .border(Color.gray, width: 1)
                    .background(Color.init(white: 0.95))
                    .cornerRadius(16)
                    
                    Button("Scan") {
                        nfcController.startScan()
                    }
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(30)
                }
            }
            .padding()
        }
        
        .alert("Duplicate detected", isPresented: $playerStore.duplicateScanAlert) {
            Button("Dismiss", role: .cancel) {}
        } message: {
            Text("Please do not scan the same peg.")
        }
    }
}

#Preview {
    ContentView()
}
