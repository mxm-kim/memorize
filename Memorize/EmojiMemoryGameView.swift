//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Maksim Kim on 12.06.2020.
//  Copyright © 2020 Bellerage. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var emojiGame: EmojiMemoryGame
    var body: some View {
        GridView(emojiGame.cards) { card in
            CardView(card: card).onTapGesture {
                self.emojiGame.choose(card: card)
            }
        }
        .padding()
        .foregroundColor(Color.orange)
    }
}

struct CardView: View {
    let cornerRadius: CGFloat = 10.0
    let borderWidth: CGFloat = 3.0

    var card: MemoryGame<String>.Card

    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }

    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: borderWidth)
                Text(card.content)
            } else if !card.isMatched {
                RoundedRectangle(cornerRadius: cornerRadius).fill()
            }
        }
        .font(self.font(for: size))
        .padding(5.0)
    }

    func font(for size: CGSize) -> Font {
        let fontSize = min(size.width, size.height) * 0.75
        return Font.system(size: fontSize)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(emojiGame: EmojiMemoryGame())
    }
}
