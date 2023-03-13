//
//  Area.swift
//  Sudoku
//
//  Created by Hauke Marquard on 09.03.23.
//

import SwiftUI

struct Area: View {
    
    var roundedBorder: [UIRectCorner] = []
    
    var einstiegDatas: [AreaAndField]
    
    var area: AreaAndField = .zero
    
    func calculatePos(i: Int, j: Int) -> Int {
        return i * 3 + j
    }
    
    @EnvironmentObject var vM: ViewModel
    
    @Binding var selectedArea: AreaAndField
    @Binding var selectedField: AreaAndField
    @Binding var selectedValue: AreaAndField
    

    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<3) { i in
                HStack(spacing: 0) {
                    ForEach(0..<3) { j in
                        Field(
                            roundedBorder: i == 0 && j == 0 && roundedBorder.contains(.topLeft) ? [.topLeft] :
                                i == 0 && j == 2 && roundedBorder.contains(.topRight) ? [.topRight] :
                                i == 2 && j == 0 && roundedBorder.contains(.bottomLeft) ? [.bottomLeft] :
                                i == 2 && j == 2 && roundedBorder.contains(.bottomRight) ? [.bottomRight] : [],
                            fieldValue: einstiegDatas[calculatePos(i: i, j: j)],
                            area: area,
                            field: AreaAndField(rawValue: String(calculatePos(i: i, j: j))) ?? .zero,
                            selectedArea: $selectedArea,
                            selectedField: $selectedField,
                            selectedValue: $selectedValue
                        )
                    }
                }
            }
        }
        .overlay(
            GeometryReader { geometry in
                Path { path in
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
 
                }
                .stroke(Color.black, lineWidth: 2)
            }
        )
        
    }
}

struct Area_Previews: PreviewProvider {
    static var previews: some View {
        Area(einstiegDatas: [.zero,.five,.zero,.zero,.zero,.three,.one,.eight,.zero], selectedArea: .constant(.one), selectedField: .constant(.one), selectedValue: .constant(.one))
            .environmentObject(ViewModel())
    }
}
