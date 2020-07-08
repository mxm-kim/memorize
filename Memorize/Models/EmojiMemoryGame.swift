//
//  EmojiMemoryVM.swift
//  Memorize
//
//  Created by Maksim Kim on 12.06.2020.
//  Copyright © 2020 Bellerage. All rights reserved.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    @Published private var game: MemoryGame<String>!
    @Published private(set) var chosenTheme: String!

    let themes = [
        "Haloween": ["👻", "🎃", "😈", "🙀", "🧙‍♀️", "🕷"],
        "Sports": ["🎾", "🎿", "🏀", "🏂", "🏈", "⚽️"],
        "Flags": ["🇹🇩", "🇲🇾", "🇦🇺", "🇹🇼", "🇨🇿", "🇸🇪"],
        "Food": ["🧀", "🧇", "🌮", "🌭", "🍔", "🍕"],
        "Cars": ["🚗", "🚙", "🚚", "🚛", "🏎", "🛺"],
        "Birds": ["🦜", "🦢", "🦩", "🐧", "🐦", "🦆"],
    ]

    var cards: Array<MemoryGame<String>.Card> {
        return game.cards
    }
    var score: Int {
        return game.score
    }

    init() {
        startNewGame()
    }

    func startNewGame() {
        let themeNames = Array(themes.keys)
        let theme = themeNames[Int.random(in: themeNames.indices)]

        var emojis = themes[theme]!
        let numberOfPairs = Int.random(in: 2...5)
        game = MemoryGame<String>(numberOfPairsOfCards: numberOfPairs) {_ in emojis.remove(at: Int.random(in: emojis.indices)) }
        chosenTheme = theme
    }

    func choose(card: MemoryGame<String>.Card) {
        game.choose(card: card)
    }
}
