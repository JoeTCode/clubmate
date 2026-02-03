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
    @State private var editMode: EditMode = .inactive
    
    struct Player: Identifiable {
        let id = UUID()
        var name: String
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
                }

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
                    .onDelete { offsets in
                        self.playerStore.players.remove(atOffsets: offsets)
                    }
                    
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
                        .background(Color.init(white: 0.95))
                        .clipShape(
                            .rect(
                                topLeadingRadius: 18,
                                bottomLeadingRadius: 18,
                                bottomTrailingRadius: 18,
                                topTrailingRadius: 18
                            )
                        )
                }
                .environment(\.editMode, $editMode)
                .toolbar {
                    Button(editMode == .active ? "Done" : "Edit") {
                        if (editMode == .active) {
                            editMode = .inactive
                            enableRowEdit = false
                            editListFocused = false
                        } else {
                            editMode = .active
                            enableRowEdit = true
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .border(Color.init(white: 0.95), width: 2)
            
                VStack {
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
