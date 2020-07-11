//
//  Cardify.swift
//  Memorize
//
//  Created by Maksim Kim on 08.07.2020.
//  Copyright © 2020 Bellerage. All rights reserved.
//

import Foundation
import SwiftUI

struct Cardify: AnimatableModifier {
    var rotation: Double

    var isFaceUp: Bool {
        rotation < 90
    }
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }

    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }

    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: borderWidth)
                content
            }
                .opacity(isFaceUp ? 1 : 0)
            RoundedRectangle(cornerRadius: cornerRadius).fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }

    let cornerRadius: CGFloat = 10.0
    let borderWidth: CGFloat = 3.0
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
