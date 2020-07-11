//
//  Pie.swift
//  Memorize
//
//  Created by Maksim Kim on 08.07.2020.
//  Copyright © 2020 Bellerage. All rights reserved.
//

import Foundation
import SwiftUI

struct Pie: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool

    var animatableData: AnimatablePair<Double, Double> {
        get {
            return AnimatablePair<Double, Double>(startAngle.radians, endAngle.radians)
        }
        set {
            startAngle = Angle.radians(newValue.first)
            endAngle = Angle.radians(newValue.second)
        }
    }

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height)/2

        let startX = center.x + CGFloat(cos(startAngle.radians))*radius
        let startY = center.y + CGFloat(sin(startAngle.radians))*radius
        let startPoint = CGPoint(x: startX, y: startY)

        var path = Path()
        path.move(to: center)
        path.addLine(to: startPoint)
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        path.addLine(to: center)
        return path
    }
}
