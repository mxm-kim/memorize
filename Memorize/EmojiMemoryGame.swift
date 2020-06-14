//
//  EmojiMemoryVM.swift
//  Memorize
//
//  Created by Maksim Kim on 12.06.2020.
//  Copyright © 2020 Bellerage. All rights reserved.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    @Published private var game: MemoryGame<String>

    var cards: Array<MemoryGame<String>.Card> {
        return game.cards
    }

    init() {
        var emojis = ["👻", "🎃", "😈", "🙀", "🧙‍♀️", "🕷"]
        let numberOfPairs = Int.random(in: 2...5)
        game = MemoryGame<String>(numberOfPairsOfCards: numberOfPairs) {_ in emojis.remove(at: Int.random(in: emojis.indices)) }
    }

    func choose(card: MemoryGame<String>.Card) {
        game.choose(card: card)
    }
}
