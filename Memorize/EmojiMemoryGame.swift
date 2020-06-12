//
//  EmojiMemoryVM.swift
//  Memorize
//
//  Created by Maksim Kim on 12.06.2020.
//  Copyright © 2020 Bellerage. All rights reserved.
//

import Foundation

class EmojiMemoryGame {
    private var game: MemoryGame<String>

    var cards: Array<MemoryGame<String>.Card> {
        return game.cards
    }

    init() {
        let emojis = ["👻", "🎃"]
        game = MemoryGame<String>(numberOfPairsOfCards: emojis.count) { emojis[$0] }
    }

    func choose(card: MemoryGame<String>.Card) {
        game.choose(card: card)
    }
}
