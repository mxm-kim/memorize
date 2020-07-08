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
        VStack {
            Text(emojiGame.chosenTheme)
                .font(Font.largeTitle)
            GridView(emojiGame.cards) { card in
                CardView(card: card).onTapGesture {
                    self.emojiGame.choose(card: card)
                }
            }
                .padding()
                .foregroundColor(Color.orange)
            Text("Score: \(String(emojiGame.score))")
                .font(Font.body)
            Button(action: {
                self.emojiGame.startNewGame()
            }) {
                Text("New game")
                    .font(Font.title)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(emojiGame: game)
    }
}
