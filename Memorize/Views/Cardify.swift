//
//  Cardify.swift
//  Memorize
//
//  Created by Maksim Kim on 08.07.2020.
//  Copyright © 2020 Bellerage. All rights reserved.
//

import Foundation
import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: borderWidth)
                Pie(startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 130), clockwise: true)
                    .padding(3.0)
                    .opacity(0.7)
                content
            } else {
                RoundedRectangle(cornerRadius: cornerRadius).fill()
            }
        }
    }

    let cornerRadius: CGFloat = 10.0
    let borderWidth: CGFloat = 3.0
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
