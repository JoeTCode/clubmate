//
//  NFCController.swift
//  Clubmate
//
//

import CoreNFC
import Combine

class NFCController: NSObject, NFCNDEFReaderSessionDelegate, ObservableObject {
    private var session: NFCNDEFReaderSession?
    private var playerStore = PlayerStore.shared
    
    func startScan() {
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        session?.alertMessage = "Hold your iPhone near the player peg."
        session?.begin()
    }
    
    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
        debugPrint("NFC session active")
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: any Error) {
        print("An error occurred while initiating reader session: \(error)")
    }
    
    // Runs after tag is detected in startScan
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        for message in messages {
            for record in message.records {
                let text = String(data: record.payload.advanced(by: 3), encoding: .utf8)!
                print("Text data: \(text)")
                
                struct TagObject: Codable {
                    let id: Int
                }
                
                do {
                    let object = try JSONDecoder().decode(TagObject.self, from: text.data(using: .utf8)!)
                    print(object.id)
                    if let name = Players.shared.name(id: object.id) {
                        print("Player name: \(name)")
                        DispatchQueue.main.async {
                            self.playerStore.addPlayer(name: name)
                        }
                    }
                    
                } catch {
                    print("Error")
                }
            }
        }
    }
}
