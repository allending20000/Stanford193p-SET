//
//  CardColorView.swift
//  Set Game
//
//  Created by Allen Ding on 3/23/21.
//

import SwiftUI

//View for color and shading of the card
//Reader Note: Tried to shorten this method but I couldn't figure a way to isolate shading and color
struct CardColorAndShadingView<ItemShape>: View where ItemShape:Shape{
    var cardColor: SetGameVM.colors
    var cardShading: SetGameVM.shadings
    var itemShape: ItemShape
    
   var body: some View {
        if cardShading == .solid {
            if cardColor == .blue {
                itemShape.fill(Color.blue)
            } else if cardColor == .pink {
                itemShape.fill(Color.pink)
            } else {
                itemShape.fill(Color.green)
            }
        } else if cardShading == .striped {
            Group {
                if cardColor == .blue {
                    itemShape.fill(Color.blue)
                } else if cardColor == .pink {
                    itemShape.fill(Color.pink)
                } else {
                    itemShape.fill(Color.green)
                }
            }
            .opacity(opacity)
        } else {
            if cardColor == .blue {
                itemShape.stroke(Color.blue, lineWidth: lineWidth)
            } else if cardColor == .pink {
                itemShape.stroke(Color.pink, lineWidth: lineWidth)
            } else {
                itemShape.stroke(Color.green, lineWidth: lineWidth)
            }
        }
    }
    // MARK: - Drawing Constants
    var opacity = 0.3
    var lineWidth: CGFloat = 3
}
