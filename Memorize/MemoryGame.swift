//
//  MemoryGame.swift
//  Memorize
//
//  Created by Maksim Kim on 12.06.2020.
//  Copyright © 2020 Bellerage. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>

    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        var unShuffledCards = Array<Card>()
        for indexOfPair in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(indexOfPair)
            unShuffledCards.append(Card(content: content, id: indexOfPair*2))
            unShuffledCards.append(Card(content: content, id: indexOfPair*2 + 1))
        }

        cards = Array<Card>()
        for _ in unShuffledCards.indices {
            cards.append(unShuffledCards.remove(at: Int.random(in: 0..<unShuffledCards.count)))
        }
    }

    func choose(card: Card) {
        print("Card chosen: \(card)")
    }

    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        var id: Int
    }
}
