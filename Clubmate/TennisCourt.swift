////
////  TennisCourt.swift
////  Clubmate
////
////

//VStack {
//    ZStack {
//        Rectangle()
//            .fill(Color.white)
//        ZStack {
//            Rectangle()
//                .fill(Color.green)
//            VerticalTennisCourtLines()
//                .stroke(Color.white, lineWidth: 2)
//        }
//        .frame(width: 280, height: 500)
//        .border(Color.init(white: 0.9), width: 2)
//        VerticalTennisCourtNetcord()
//            .fill(Color.init(white:0.9))
//        VerticalTennisCourtNetBottom()
//        VerticalTennisCourtNetPosts()
//    }
//    .frame(width: 360, height: 300)
//}

import SwiftUI


struct CourtConfig {
    // Calculated shared logic
    static func netcordHeight(for rect: CGRect) -> CGFloat {
        let scalingFactor = 40 + (rect.maxY).squareRoot()
        return (rect.maxY - scalingFactor) / 2
    }
}

struct VerticalTennisCourtLines: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let tramlineWidth = CGFloat(50)
        let courtOutlineLeadingX = CGFloat(0)
        let courtOutlineLeadingY = CGFloat(0)
        
        // Court Outline
        path.addRect(CGRect(x: courtOutlineLeadingX, y: courtOutlineLeadingY,
                            width: rect.maxX - (courtOutlineLeadingX * 2), height: rect.maxY))
        
        // Left tramline
        path.addRect(CGRect(x: courtOutlineLeadingX, y: courtOutlineLeadingY,
                            width: tramlineWidth, height: rect.maxY))
        
        // Right tramline
        path.addRect(CGRect(x: rect.maxX - (courtOutlineLeadingX), y: courtOutlineLeadingY,
                            width: -tramlineWidth, height: rect.maxY))
        
        // Right service box
        path.addRect(CGRect(x: rect.maxX / 2, y: rect.maxY / 4,
                            width: ((rect.maxX / 2) - (tramlineWidth + courtOutlineLeadingX)), height: (rect.maxY) / 2))
        
        // Left service box
        path.addRect(CGRect(x: rect.maxX / 2, y: rect.maxY / 4,
                            width: -((rect.maxX / 2) - (tramlineWidth + courtOutlineLeadingX)), height: (rect.maxY) / 2))
        
        return path
    }
}

struct VerticalTennisCourtNetcord: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let netcordThickness = CGFloat(6)
        let netcordHeight = CourtConfig.netcordHeight(for: rect)
        
        // Netcord
        path.addRect(CGRect(x: 0, y: netcordHeight,
                            width: rect.maxX, height: netcordThickness))
    
        return path
    }
}

struct VerticalTennisCourtNetBottom: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let netBottomThickness = CGFloat(2)
        
        // Net
        path.addRect(CGRect(x: 0, y: (rect.maxY) / 2,
                            width: rect.maxX, height: netBottomThickness))
        
        return path
    }
}

struct VerticalTennisCourtNetPosts: Shape {
    let config = CourtConfig()
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let postWidth = CGFloat(8)
        let netcordHeight = CourtConfig.netcordHeight(for: rect)
        
        // Left post
        path.addRect(CGRect(x: 0, y: netcordHeight - 3,
                            width: postWidth, height: abs(netcordHeight - rect.maxY / 2) + 3))
        
        // Right post
        path.addRect(CGRect(x: rect.maxX, y: netcordHeight - 3,
                            width: -postWidth, height: abs(netcordHeight - rect.maxY / 2) + 3))
        
        return path
    }
}
