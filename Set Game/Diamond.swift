//
//  Diamond.swift
//  Set Game
//
//  Created by Allen Ding on 3/23/21.
//

import SwiftUI

//Custom diamond shape
struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x:rect.minX, y:rect.midY))
        p.addLine(to: CGPoint(x:rect.midX, y:rect.maxY))
        p.addLine(to: CGPoint(x:rect.maxX, y:rect.midY))
        p.addLine(to: CGPoint(x:rect.midX, y:rect.minY))
        p.addLine(to: CGPoint(x:rect.minX, y:rect.midY))
        return p
    }
}
