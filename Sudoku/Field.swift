//
//  Field.swift
//  Sudoku
//
//  Created by Hauke Marquard on 09.03.23.
//

import SwiftUI

struct Field: View {
    
    var roundedBorder: [UIRectCorner] = [.topLeft]
    var fieldValue: AreaAndField = .zero
    
    var area: AreaAndField = .zero
    var field: AreaAndField = .one
    
    @Binding var selectedArea: AreaAndField
    @Binding var selectedField: AreaAndField
    @Binding var selectedValue: AreaAndField
    
    @State var selected: Bool = false
    
    @State var beginValue: Bool = false

    @State var showLine: Bool = false
    @State var showArea: Bool = false
    @State var showWrongEntry: Bool = true
    
    @EnvironmentObject var vM: ViewModel
    
    var selectedFieldColor: Color = Color.accentColor.opacity(0.7)
    var highlightedFieldColor: Color = .blue.opacity(0.7)
    var beginFieldColor: Color = .gray.opacity(0.7)
    var wrongEntryFieldColor: Color = .red.opacity(0.7)
    
    func isActualSelected() -> Bool {
        return selectedArea == area && selectedField == field
    }
    
    var body: some View {
        ZStack {
            VStack {
                if beginValue {
                    Text(vM.getEinstiegValue(area: area, field: field).rawValue)
                } else {
                    if let value = vM.getEintragungenValue(area: area, field: field) {
                        if value == .zero {
                            Text(" ")
                        } else {
                            Text(value.rawValue)
                        }
                    }
                }
            }
            CandidateFieldView(area: area, field: field, values: [.one, .three, .seven, .nine])
        }
        .font(.title2)
        .frame(width: 40, height: 40)
        .background(strokeAndFill())
        .background(strokeAndFill(fill: true))
        .onTapGesture {
            selected = true
            selectedArea = area
            selectedField = field
            selectedValue = fieldValue
//            vM.setValue(area: area, field: field, value: .five)
            vM.setPopupField(area: area, field: field)

        }
        .onAppear {
            if vM.getEinstiegValue(area: area, field: field) != .zero {
                beginValue = true
            }
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
                p.fill(isActualSelected() ? selectedFieldColor :
                        amIHighlighted() ? highlightedFieldColor :
                            beginValue ? beginFieldColor :
                        showWrongEntry && !vM.isEntryValid(area: area, field: field) ? wrongEntryFieldColor : .clear)
            } else {
                p.stroke(Color.secondary, lineWidth: 1)
            }
        }
    }

    
    func amIHighlighted() -> Bool {
        var value:Bool = false
        if showLine {
            if let sArea = dict[selectedArea], sArea.contains(area) {
                let areaPos:AreaPos = whereIsTheArea()
                
                switch areaPos {
                case .horizontal:
                    switch selectedField {
                    case .zero, .one, .two:
                        value = field == .zero || field == .one || field == .two
                    case .three, .four, .five:
                        value = field == .three || field == .four || field == .five
                    case .six, .seven, .eight:
                        value = field == .six || field == .seven || field == .eight
                    case .nine:
                        value = false
                    }
                case .vertical:
                    switch selectedField {
                    case .zero, .three, .six:
                        value = field == .zero || field == .three || field == .six
                    case .one, .four, .seven:
                        value = field == .one || field == .four || field == .seven
                    case .two, .five, .eight:
                        value = field == .two || field == .five || field == .eight
                    case .nine:
                        value = false
                    }
                }
                
    //            value = true
            } else {
                value = false
            }
        }
        
        
        if showArea && selectedArea == area {
            value = true
        }
        
        if selectedValue == fieldValue {
            value = true
        }
        
        if selectedValue == .zero { value = false }
        return value
    }
    
    func whereIsTheArea() -> AreaPos {
        var areaPos = AreaPos.horizontal
        
        if let sArea = horizontalDict[selectedArea], sArea.contains(area) {
            areaPos = .horizontal
        } else if let sArea = verticalDict[selectedArea], sArea.contains(area) {
            areaPos = .vertical
        }
        
        return areaPos
    }
    
}

enum AreaPos: String {
    case horizontal, vertical
}


struct Field_Previews: PreviewProvider {
    static var previews: some View {
        Field(selectedArea: .constant(.one), selectedField: .constant(.two), selectedValue: .constant(.two))
            .environmentObject(ViewModel())
    }
}

var dict: [AreaAndField : [AreaAndField]] = [
    .zero:[.one,.two,.three,.six],
    .one:[.zero,.two,.four, .seven],
    .two:[.zero,.one,.five,.eight],
    .three:[.zero,.six,.four,.five],
    .four:[.one, .seven,.three,.five],
    .five:[.three,.four,.two,.eight],
    .six:[.zero,.three, .seven,.eight],
    .seven:[.six,.eight,.one,.four],
    .eight:[.two,.five,.six, .seven]
]

var horizontalDict: [AreaAndField: [AreaAndField]] = [
    .zero: [.one,.two],
    .one: [.zero,.two],
    .two: [.zero,.one],
    .three: [.four,.five],
    .four: [.three,.five],
    .five: [.three,.four],
    .six: [ .seven,.eight],
    .seven: [.six,.eight],
    .eight: [.six, .seven],
]

var verticalDict: [AreaAndField: [AreaAndField]] = [
    .zero: [.three,.six],
    .one: [.four, .seven],
    .two: [.five,.eight],
    .three: [.zero,.six],
    .four: [.one, .seven],
    .five: [.two,.eight],
    .six: [.zero,.three],
    .seven: [.one,.four],
    .eight: [.two,.five],
]
