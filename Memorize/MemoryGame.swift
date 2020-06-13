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

    mutating func choose(card: Card) {
        guard let chosenIndex = index(of: card) else {
            return
        }

        cards[chosenIndex].isFaceUp = !cards[chosenIndex].isFaceUp
    }

    func index(of card: Card) -> Int? {
        cards.firstIndex(where: { $0.id == card.id })
    }


    struct Card: Identifiable {
        var isFaceUp = true
        var isMatched = false
        var content: CardContent
        var id: Int
    }
}
