//
//  GridView.swift
//  Memorize
//
//  Created by Maksim Kim on 14.06.2020.
//  Copyright © 2020 Bellerage. All rights reserved.
//

import SwiftUI

struct GridView<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    var items: [Item]
    var viewForItem: (Item) -> ItemView

    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }


    var body: some View {
        GeometryReader { geometry in
            self.body(layout: GridLayout(itemCount: self.items.count,
                                         nearAspectRatio: 3/4,
                                         in: geometry.size))
        }
    }

    func body(layout: GridLayout) -> some View {
        ForEach(items) { item in
            self.viewForItem(item, layout: layout)
        }
    }

    func viewForItem(_ item: Item, layout: GridLayout) -> some View {
        let index = items.firstIndex(matching: item)
        return viewForItem(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index!))
    }
}

