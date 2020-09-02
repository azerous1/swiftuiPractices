//
//  Pie.swift
//  StandfordDemoX
//
//  Created by Yichi Zhang  on 8/15/20.
//

import Foundation
import SwiftUI

// shape are commonly animatable, thus we don't need to say it is animatable
struct Pie: Shape {
    // 0 degree angle is out right, not on the top 
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool = false
    
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(startAngle.radians, endAngle.radians)
        }
        set {
            startAngle = Angle.radians(newValue.first)
            endAngle = Angle.radians(newValue.second)
        }
    }
 
    func path(in rect: CGRect) -> Path {
        // layout essential points for drawing the pie shape
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.height, rect.width) / 2
        let start = CGPoint(
            x: center.x + radius * cos(CGFloat(startAngle.radians)),
            y: center.y + radius * sin(CGFloat(startAngle.radians))
        )
        
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(center: center,
                 radius: radius,
                 startAngle: startAngle,
                 endAngle: endAngle,
                 clockwise: clockwise
        )
        p.addLine(to: center)
        return p
    }
}
