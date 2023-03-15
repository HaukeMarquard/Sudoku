//
//  SetValueBtnView.swift
//  Sudoku
//
//  Created by Hauke Marquard on 13.03.23.
//

import SwiftUI

struct SetValueBtnView: View {
    
    var roundedBorder: [UIRectCorner] = [.topLeft]
    var value: AreaAndField
    
    @EnvironmentObject var vM: ViewModel
    
    var body: some View {
        Group {
            if value != .zero {
                Text(value.rawValue)
                    
            } else {
                Image(systemName: "delete.backward")
            }
        }
        .font(.title).bold()
        .frame(width: 70, height: 70)
        .background(strokeAndFill())
        .background(strokeAndFill(fill: true))
        .onTapGesture {
            vM.setNormal(value: value)
        }
        
    }
    
    @ViewBuilder
    func strokeAndFill(fill: Bool = false) -> some View {
        GeometryReader { geometry in
            let p = Path { path in
                let width = geometry.size.width
                let height = geometry.size.height
                let cornerRadius = CGFloat(15)
//                    let lineWidth = CGFloat(2)
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
                path.closeSubpath()

            }
            if fill {
                p.fill(Color("fieldBackground"))
            } else {
                p.stroke(Color.secondary, lineWidth: 1)
            }
        }
    }
}

struct SetValueBtnView_Previews: PreviewProvider {
    static var previews: some View {
        SetValueBtnView(value: .one)
            .environmentObject(ViewModel())
    }
}
