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
        HStack {
            ForEach(emojiGame.cards) { card in
                CardView(card: card).onTapGesture {
                    self.emojiGame.choose(card: card)
                }
            }
        }
        .padding()
        .foregroundColor(Color.orange)
        .font(font)
    }

    var font: Font {
        let font: Font!
        if emojiGame.cards.count < 10 {
            font = Font.largeTitle
        } else {
            font = Font.body
        }
        return font
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card

    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }.aspectRatio(2/3, contentMode: .fit)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(emojiGame: EmojiMemoryGame())
    }
}
