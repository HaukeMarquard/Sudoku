//
//  Field.swift
//  Sudoku
//
//  Created by Hauke Marquard on 09.03.23.
//

import SwiftUI

struct Field: View {
    
    var roundedBorder: [UIRectCorner] = []
    var fieldValue: String = "1"
    
    var body: some View {
        VStack {
            Text(fieldValue)
        }
        .frame(width: 40, height: 40)
        .overlay(
            GeometryReader { geometry in
                Path { path in
                    let width = geometry.size.width
                    let height = geometry.size.height
                    let cornerRadius = CGFloat(15)
                    let lineWidth = CGFloat(2)
                    let topLeft = CGPoint(x: 0, y: 0)
                    let topRight = CGPoint(x: width, y: 0)
                    let bottomRight = CGPoint(x: width, y: height)
                    let bottomLeft = CGPoint(x: 0, y: height)
                    
                    if roundedBorder.contains(.topLeft) {
                        path.move(to: CGPoint(x: topLeft.x + cornerRadius, y: topLeft.y))
                    } else {
                        path.move(to: CGPoint(x: topLeft.x, y: topLeft.y))
                    }
                    
                    if roundedBorder.contains(.topRight) {
                        path.addLine(to: CGPoint(x: topRight.x - cornerRadius, y: topRight.y))
                        path.addArc(center: CGPoint(x: topRight.x - cornerRadius, y: topRight.y + cornerRadius),
                                    radius: cornerRadius,
                                    startAngle: Angle(degrees: -90),
                                    endAngle: Angle(degrees: 0),
                                    clockwise: false)
                    } else {
                        path.addLine(to: topRight)
                    }
                    
                    if roundedBorder.contains(.bottomRight) {
                        path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y - cornerRadius))
                        path.addArc(center: CGPoint(x: bottomRight.x - cornerRadius, y: bottomRight.y - cornerRadius),
                                    radius: cornerRadius,
                                    startAngle: Angle(degrees: 0),
                                    endAngle: Angle(degrees: 90),
                                    clockwise: false)
                    } else {
                        path.addLine(to: bottomRight)
                    }
                    
                    if roundedBorder.contains(.bottomLeft) {
                        path.addLine(to: CGPoint(x: bottomLeft.x + cornerRadius, y: bottomLeft.y))
                        path.addArc(center: CGPoint(x: bottomLeft.x + cornerRadius, y: bottomLeft.y - cornerRadius),
                                    radius: cornerRadius,
                                    startAngle: Angle(degrees: 90),
                                    endAngle: Angle(degrees: 180),
                                    clockwise: false)
                    } else {
                        path.addLine(to: bottomLeft)
                    }
                    
                    if roundedBorder.contains(.topLeft) {
                        path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y + cornerRadius))
                        path.addArc(center: CGPoint(x: topLeft.x + cornerRadius, y: topLeft.y + cornerRadius),
                                    radius: cornerRadius,
                                    startAngle: Angle(degrees: 180),
                                    endAngle: Angle(degrees: 270),
                                    clockwise: false)
                    } else {
                        path.addLine(to: topLeft)
                    }
 
                }
                .stroke(Color.secondary, lineWidth: 1)
            }
        )
    }
}

struct Field_Previews: PreviewProvider {
    static var previews: some View {
        Field()
    }
}
