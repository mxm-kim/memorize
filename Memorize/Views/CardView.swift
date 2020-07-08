//
//  CardView.swift
//  Memorize
//
//  Created by Maksim Kim on 08.07.2020.
//  Copyright © 2020 Bellerage. All rights reserved.
//

import Foundation
import SwiftUI

struct CardView: View {
    let cornerRadius: CGFloat = 10.0
    let borderWidth: CGFloat = 3.0

    var card: MemoryGame<String>.Card

    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }

    @ViewBuilder
    func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            Text(card.content)
                .cardify(isFaceUp: card.isFaceUp)
                .font(self.getFont(for: size))
                .padding(5.0)
        }
    }

    func getFont(for size: CGSize) -> Font {
        let fontSize = min(size.width, size.height) * 0.75
        return Font.system(size: fontSize)
    }
}
