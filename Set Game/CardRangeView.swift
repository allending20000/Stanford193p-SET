//
//  CardRangeView.swift
//  Set Game
//
//  Created by Allen Ding on 3/23/21.
//

import SwiftUI

//View for range(number of shapes) of the card
struct CardRangeView<ItemView>: View where ItemView: View{
    var cardRange: SetGameVM.range
    var itemView: ItemView
    
    var body: some View {
        if cardRange == .one {
            HStack{
                itemView
            }
        } else if cardRange == .two {
            HStack{
                itemView
                itemView
            }
        } else {
            HStack{
                itemView
                itemView
                itemView
            }
        }
    }
}
