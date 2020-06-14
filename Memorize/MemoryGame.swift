//
//  MemoryGame.swift
//  Memorize
//
//  Created by Maksim Kim on 12.06.2020.
//  Copyright © 2020 Bellerage. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: Array<Card>
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter({ cards[$0].isFaceUp }).only
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = newValue == index
            }
        }
    }
    var score: Int = 0

    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        var unShuffledCards = Array<Card>()
        for indexOfPair in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(indexOfPair)
            unShuffledCards.append(Card(content: content, id: indexOfPair*2))
            unShuffledCards.append(Card(content: content, id: indexOfPair*2 + 1))
        }

        cards = Array<Card>()
        for _ in unShuffledCards.indices {
            let randomIndex = Int.random(in: 0..<unShuffledCards.count)
            cards.append(unShuffledCards.remove(at: randomIndex))
        } 
    }

    mutating func choose(card: Card) {
        if let chosenIndex = cards.firstIndex(matching: card),
            !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {

            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[potentialMatchIndex].content == cards[chosenIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else {
                    if cards[chosenIndex].isSeen {
                        score -= 1
                    }

                    if cards[potentialMatchIndex].isSeen {
                        score -= 1
                    }

                    cards[chosenIndex].isSeen = true
                    cards[potentialMatchIndex].isSeen = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }

    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var isSeen = false
        var content: CardContent
        var id: Int
    }
}
