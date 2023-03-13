//
//  ViewModel.swift
//  Sudoku
//
//  Created by Hauke Marquard on 12.03.23.
//

import Foundation

struct CandidateDict: Hashable {
    let first: Int
    let second: Int
    let third: Int
    
    init(_ first: Int, _ second: Int, _ third: Int) {
        self.first = first
        self.second = second
        self.third = third
    }
}

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
    @Published var candidates: [CandidateDict:[AreaAndField]] = [CandidateDict(0 , 0, 2): [.one, .two]]
    @Published var normalOrCandidate: EntryType = .normal
    
    var selectedField: PopUpField = PopUpField(first: 0, second: 0, third: 0)
    
    func setValue(area: AreaAndField, field: AreaAndField, value: AreaAndField ) {
        let (first, second, third) = calculatePosition(area: area, field: field)
        eintragungen[first][second][third] = AreaAndField(rawValue: String(Int.random(in: 1...9))) ?? .zero
    }
    
    func getEinstiegValue(area: AreaAndField, field: AreaAndField) -> AreaAndField {
        let (first, second, third) = calculatePosition(area: area, field: field)
        return einstieg[first][second][third]
    }
    
    func getEintragungenValue(area: AreaAndField, field: AreaAndField) -> AreaAndField {
        let (first, second, third) = calculatePosition(area: area, field: field)
        return eintragungen[first][second][third]
    }
    
    func isEntryValid(area: AreaAndField, field: AreaAndField) -> Bool {
        let (first, second, third) = calculatePosition(area: area, field: field)
        return eintragungen[first][second][third] == loesung[first][second][third] || eintragungen[first][second][third] == .zero
    }
    
    func calculatePosition(area: AreaAndField, field: AreaAndField) -> (Int,Int,Int) {
        guard let a = Int(area.rawValue), let third = Int(field.rawValue) else { return (0,0,0) }
        let first = Int(a / 3)
        let second = Int(a % 3)
        return (first, second, third)
    }
    
    func setPopupField(area: AreaAndField, field: AreaAndField) {
        let (first, second, third) = calculatePosition(area: area, field: field)
        selectedField = PopUpField(first: first, second: second, third: third)
    }
    
    func setNormal(value: AreaAndField) {
        if normalOrCandidate == .normal {
            eintragungen[selectedField.first][selectedField.second][selectedField.third] = value
        } else {
            candidates[CandidateDict(selectedField.first, selectedField.second, selectedField.third)] = [value]
            print(candidates)
        }
        
    }
    
    func getCandidates(area: AreaAndField, field: AreaAndField) -> [AreaAndField] {
        let (first, second, third) = calculatePosition(area: area, field: field)
        guard let candidates = candidates[CandidateDict(first, second, third)] else { return [] }
        return candidates
    }
}

struct PopUpField {
    var first: Int
    var second: Int
    var third: Int
}
