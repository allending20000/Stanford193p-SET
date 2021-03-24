//
//  Grid.swift
//  Set Game
//
//  Created by Allen Ding on 3/22/21.
//

import SwiftUI

//Creating a custom container view called Grid that arranges items in a grid
struct Grid<Item, ItemView>: View where Item: Identifiable, Item: Equatable, ItemView: View{
    private var items: [Item]
    private var itemToView: (Item) -> ItemView
    
    init(items: [Item], itemToView: @escaping (Item) -> ItemView) {
        self.items = items
        self.itemToView = itemToView
    }
    
    var body: some View {
        GeometryReader { geometry in
            let gridLayout = GridLayout(itemCount: items.count, in: geometry.size)
            ForEach(items) { item in
                itemToView(item)
                    //Use GridLayout to determine the size of each item as well as its position
                    .frame(width: gridLayout.itemSize.width, height: gridLayout.itemSize.height)
                    .position(gridLayout.location(ofItemAt: items.firstIndex(where: {$0 == item})!))
            }
        }
    }
}
