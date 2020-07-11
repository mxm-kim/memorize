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
                    withAnimation(.linear(duration: 0.7)) {
                        self.emojiGame.choose(card: card)
                    }
                }.padding(3.0)
            }
                .padding()
                .foregroundColor(Color.orange)
            Text("Score: \(String(emojiGame.score))")
                .font(Font.body)
            Button(action: {
                withAnimation(.easeInOut(duration: 0.8)) {
                    self.emojiGame.startNewGame()
                }
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

struct CardView: View {
    let cornerRadius: CGFloat = 10.0
    let borderWidth: CGFloat = 3.0

    var card: MemoryGame<String>.Card

    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }

    @State private var animatedBonusRemaining: Double = 0

    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }

    @ViewBuilder
    func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: -animatedBonusRemaining*360-90), clockwise: true)
                            .onAppear {
                                self.startBonusTimeAnimation()
                        }
                    } else {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: -card.bonusRemaining*360-90), clockwise: true)
                    }
//                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 60-90), clockwise: true)
//                    .animation(.linear)
                }
                .padding(3.0)
                .opacity(0.4)
                Text(card.content)
                    .font(self.getFont(for: size))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1.0).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
        }
    }

    func getFont(for size: CGSize) -> Font {
        let fontSize = min(size.width, size.height) * 0.75
        return Font.system(size: fontSize)
    }
}
