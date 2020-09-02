//
//  Grid.swift
//  StandfordDemoX
//
//  Created by Yichi Zhang  on 8/9/20.
//

import SwiftUI

// <item, itemview> are generic (don't care)
// however, we care a little bit here since we want item to be identifiable for the purpose of the for each
struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    private var items: [Item]
    private var viewForItem: (Item) -> ItemView
    
    // init solves for ?
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader {geometry in
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }
    
    private func body(for layout: GridLayout) -> some View {
        ForEach(items) { item in
            self.body(for: item, in: layout)
        }
    }
    
    // "self." : use to differnntiate between local variable and function
    private func body(for item: Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(matching: item)!
        return viewForItem(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index)) // "!" unwrap the optional case
    }
}

