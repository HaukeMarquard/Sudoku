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
    @Published var eintragungen: [[[AreaAndField]]] = blankoEintragungen
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
    @Published var candidates: [CandidateDict:[AreaAndField]] = [:]
    @Published var normalOrCandidate: EntryType = .normal
    @Published var showLine: Bool = false
    @Published var showArea: Bool = false
    @Published var showWrongEntry: Bool = true
    
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
            if value == .zero {
                candidates[CandidateDict(selectedField.first, selectedField.second, selectedField.third)] = []
            } else if var array = candidates[CandidateDict(selectedField.first, selectedField.second, selectedField.third)] {
                if array.contains(value) {
                    let index = array.firstIndex(of: value) ?? 0
                    array.remove(at: index)
                    candidates[CandidateDict(selectedField.first, selectedField.second, selectedField.third)] = array
                } else {
                    array.append(value)
                    candidates[CandidateDict(selectedField.first, selectedField.second, selectedField.third)] = array
                }
            } else {
                candidates[CandidateDict(selectedField.first, selectedField.second, selectedField.third)] = [value]
            }
        }
        
    }
    
    func getCandidates(area: AreaAndField, field: AreaAndField) -> [AreaAndField] {
        let (first, second, third) = calculatePosition(area: area, field: field)
        guard let candidates = candidates[CandidateDict(first, second, third)] else { return [] }
        return candidates
    }
    
    func getFieldValue(area: AreaAndField, field: AreaAndField) -> AreaAndField {
        let (first, second, third) = calculatePosition(area: area, field: field)
        guard einstieg[first][second][third] != nil else { return .zero }
        return einstieg[first][second][third] == .zero ? eintragungen[first][second][third] : einstieg[first][second][third]
    }
    
    func setNewLevel() {
        einstieg = createOwnFormat()
        eintragungen = blankoEintragungen
    }
    
}

func getCSVData() -> Array<String> {
    
    if let filepath = Bundle.main.path(forResource: "sudokus", ofType: "csv") {
        do {
            let contents = try String(contentsOfFile: filepath)
            let parsedCSV: [String] = contents.components(
                separatedBy: "\n"
            ).map{ $0.components(separatedBy: ",")[0] };        return parsedCSV
            // Verarbeite den Inhalt der Datei hier weiter
        } catch {
            print("Fehler beim Lesen der Datei: \(error)")
            return []
        }
    } else {
        print("Datei nicht gefunden.")
        return []
    }
}

func createOwnFormat() -> [[[AreaAndField]]] {
    var things: [[[AreaAndField]]] =
    [
        [
            [],[],[]
        ],
        [
            [],[],[]
        ],
        [
            [],[],[]
        ]
    ]
    let randInt = Int.random(in: 0...999)
    var inputArray = getCSVData()[randInt]
    var array = Array(inputArray)
    let subArrays = array.chunked(into: 27)
    for i in 0..<3 {
        var arrayIndex: Int = 0
        for j in stride(from: 0, to: 25, by: 3) {
            things[i][arrayIndex].append(AreaAndField(rawValue: String(subArrays[i][j])) ?? .zero)
            things[i][arrayIndex].append(AreaAndField(rawValue: String(subArrays[i][j+1])) ?? .zero)
            things[i][arrayIndex].append(AreaAndField(rawValue: String(subArrays[i][j+2])) ?? .zero)
            if arrayIndex < 2 {
                arrayIndex += 1
            } else {
                arrayIndex = 0
            }
        }
    }
    return things
}

struct PopUpField {
    var first: Int
    var second: Int
    var third: Int
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

var blankoEintragungen: [[[AreaAndField]]] = [
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
