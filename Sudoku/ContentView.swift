//
//  ContentView.swift
//  Sudoku
//
//  Created by Hauke Marquard on 28.01.23.
//

import SwiftUI

struct ContentView: View {
    
    
    @State var einstieg: [[[AreaAndField]]] = [
        [
            [.zero,.five,.zero,.zero,.zero,.three,.one,.eight,.zero],
            [.zero,.one,.nine,.zero,.zero,.five,.zero,.four,.seven],
            [.zero,.two,.zero,.zero,.zero,.eight,.nine,.zero,.zero]
        ],
        [
            [.zero,.four,.zero,.zero,.seven,.zero,.six,.two,.eight],
            [.zero,.three,.eight,.four,.zero,.zero,.seven,.nine,.one],
            [.two,.seven,.nine,.six,.eight,.one,.four,.five,.three]
        ],
        [
            [.zero,.zero,.five,.eight,.six,.zero,.zero,.zero,.zero],
            [.zero,.eight,.zero,.one,.zero,.three,.zero,.zero,.zero],
            [.zero,.four,.zero,.zero,.zero,.two,.zero,.three,.zero]]
    ]
    
    
    @State var selectedArea: AreaAndField = .zero
    @State var selectedField: AreaAndField = .zero
    @State var selectedValue: AreaAndField = .zero
    
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<3) { i in
                HStack(spacing: 0) {
                    ForEach(0..<3) { j in
                        if i == 0 && j == 0 {
                            Area(
                                roundedBorder: [.topLeft],
                                einstiegDatas: einstieg[i][j],
                                area: calculateArea(i: i, j: j),
                                selectedArea: $selectedArea,
                                selectedField: $selectedField,
                                selectedValue: $selectedValue
                            )
                        } else if i == 0 && j == 2 {
                            Area(
                                roundedBorder: [.topRight],
                                einstiegDatas: einstieg[i][j],
                                area:  calculateArea(i: i, j: j),
                                selectedArea: $selectedArea,
                                selectedField: $selectedField,
                                selectedValue: $selectedValue
                            )
                        } else if i == 2 && j == 0 {
                            Area(
                                roundedBorder: [.bottomLeft],
                                einstiegDatas: einstieg[i][j],
                                area: calculateArea(i: i, j: j),
                                selectedArea: $selectedArea,
                                selectedField: $selectedField,
                                selectedValue: $selectedValue
                            )
                        } else if i == 2 && j == 2 {
                            Area(
                                roundedBorder: [.bottomRight],
                                einstiegDatas: einstieg[i][j],
                                area: calculateArea(i: i, j: j),
                                selectedArea: $selectedArea,
                                selectedField: $selectedField,
                                selectedValue: $selectedValue
                            )
                        } else {
                            Area(
                                einstiegDatas: einstieg[i][j],
                                area: calculateArea(i: i, j: j),
                                selectedArea: $selectedArea,
                                selectedField: $selectedField,
                                selectedValue: $selectedValue
                            )
                        }
                        
                    }
                }
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.black, lineWidth: 5)
        )
    }
    
    func calculateArea(i: Int, j: Int) -> AreaAndField {
        return AreaAndField(rawValue: String(i * 3 + j)) ?? .zero
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

enum AreaAndField: String {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
}
