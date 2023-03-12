//
//  ViewModel.swift
//  Sudoku
//
//  Created by Hauke Marquard on 12.03.23.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var einstieg: [[[AreaAndField]]] = [
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
    @Published var eintragungen: [[[AreaAndField]]] = [
        [
            [.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero],
            [.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero],
            [.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero]
        ],
        [
            [.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero],
            [.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero],
            [.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero]
        ],
        [
            [.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero],
            [.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero],
            [.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero]
        ]
    ]
    @Published var loesung: [[[AreaAndField]]] = [
        [
            [.seven, .five, .six, .four, .nine, .three, .one, .eight, .two],
            [.eight, .one, .nine, .two, .six, .five, .three, .four, .seven],
            [.three, .two, .four, .seven, .one, .eight, .nine, .six, .five]
        ],
        [
            [.five, .four, .one, .three, .seven, .nine, .six, .two, .eight],
            [.six, .three, .eight, .four, .five, .two, .seven, .nine, .one],
            [.two, .seven, .nine, .six, .eight, .one, .four, .five, .three]
        ],
        [
            [.two, .three, .five, .eight, .six, .four, .nine, .one, .seven],
            [.nine, .eight, .six, .one, .seven, .three, .five, .two, .four],
            [.one, .four, .seven, .five, .nine, .two, .eight, .three, .six]
        ]
    ]
    
    func setValue(area: AreaAndField, field: AreaAndField, value: AreaAndField ) {
        guard let a = Int(area.rawValue), let third = Int(field.rawValue) else { return }
        let first = Int(a / 3)
        let second = Int(a % 3)
        eintragungen[first][second][third] = value
        
    }
}
