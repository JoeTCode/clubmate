//
//  ContentView.swift
//  Clubmate
//
//

import SwiftUI

struct VerticalTennisCourtLines: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let netWidth = CGFloat(10)
        let tramlineWidth = CGFloat(40)
        
        // Court Outline
        path.addRect(CGRect(x: 0, y: 0,
                            width: rect.maxX, height: rect.maxY))
        
        // Left tramline
        path.addRect(CGRect(x: 0, y: 0,
                            width: tramlineWidth, height: rect.maxY))
        
        // Right tramline
        path.addRect(CGRect(x: rect.maxX, y: 0,
                            width: -tramlineWidth, height: rect.maxY))
        
        // Right service box
        path.addRect(CGRect(x: rect.maxX / 2, y: rect.maxY / 4,
                            width: (rect.maxX - 80) / 2, height: (rect.maxY + netWidth) / 2))
        
        // Left service box
        path.addRect(CGRect(x: rect.maxX / 2, y: rect.maxY / 4,
                            width: -(rect.maxX - 80) / 2, height: (rect.maxY + netWidth) / 2))
        
        return path
    }
}

struct VerticalTennisCourtNet: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let netWidth = CGFloat(10)
        
        // Net
        path.addRect(CGRect(x: 0, y: rect.maxY / 2,
                            width: rect.maxX, height: netWidth))
        
        return path
    }
}

struct ContentView: View {
    
    var body: some View {
        TabView {
            NavigationView {
                PlayerList()
            }
            .tabItem {
                Label("Players", systemImage: "person.3.fill")
            }
            NavigationView {
                Courts()
            }
            .tabItem {
                Label("Courts", systemImage: "tennisball.fill")
            }
        }
        
//        ZStack {
//            Rectangle()
//                .fill(Color.green)
//            VerticalTennisCourtLines()
//                .stroke(Color.white, lineWidth: 2)
//            VerticalTennisCourtNet()
//                .fill(Color.white)
//        }
//        .frame(width: 200, height: 300)

    }
}

#Preview {
    ContentView()
}
