//
//  CardShapeView.swift
//  Set Game
//
//  Created by Allen Ding on 3/23/21.
//

import SwiftUI

//View for shape of the card
struct CardShapeView: Shape {
    var cardShape: SetGameVM.shapes
    
    //conforms to Shape protocol
    func path(in rect: CGRect) -> Path {
        if cardShape == .squiggle {
            return Rectangle().path(in: rect)
        } else if cardShape == .diamond {
            return Diamond().path(in: rect)
        } else {
            return Capsule().path(in: rect)
        }
    }

    var body: some View {
        if cardShape == .squiggle {
            Rectangle()
        } else if cardShape == .diamond {
            Diamond()
        } else {
            Capsule()
        }
    }
}
