//
//  ContentView.swift
//  Sudoku
//
//  Created by Hauke Marquard on 28.01.23.
//

import SwiftUI

struct ContentView: View {
    
    
//    @State var einstieg: [[[AreaAndField]]] = [
//        [
//            [.zero,.five,.zero,.zero,.zero,.three,.one,.eight,.zero],
//            [.zero,.one,.nine,.zero,.zero,.five,.zero,.four,.seven],
//            [.zero,.two,.zero,.zero,.zero,.eight,.nine,.zero,.zero]
//        ],
//        [
//            [.zero,.four,.zero,.zero,.seven,.zero,.six,.two,.eight],
//            [.zero,.three,.eight,.four,.zero,.zero,.seven,.nine,.one],
//            [.two,.seven,.nine,.six,.eight,.one,.four,.five,.three]
//        ],
//        [
//            [.zero,.zero,.five,.eight,.six,.zero,.zero,.zero,.zero],
//            [.zero,.eight,.zero,.one,.zero,.three,.zero,.zero,.zero],
//            [.zero,.four,.zero,.zero,.zero,.two,.zero,.three,.zero]]
//    ]
//    @State var eintragungen: [[[AreaAndField]]] = [
//        [
//            [.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero],
//            [.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero],
//            [.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero]
//        ],
//        [
//            [.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero],
//            [.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero],
//            [.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero]
//        ],
//        [
//            [.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero],
//            [.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero],
//            [.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero,.zero]
//        ]
//    ]
//    @State var loesung: [[[AreaAndField]]] = [
//        [
//            [.seven, .five, .six, .four, .nine, .three, .one, .eight, .two],
//            [.eight, .one, .nine, .two, .six, .five, .three, .four, .seven],
//            [.three, .two, .four, .seven, .one, .eight, .nine, .six, .five]
//        ],
//        [
//            [.five, .four, .one, .three, .seven, .nine, .six, .two, .eight],
//            [.six, .three, .eight, .four, .five, .two, .seven, .nine, .one],
//            [.two, .seven, .nine, .six, .eight, .one, .four, .five, .three]
//        ],
//        [
//            [.two, .three, .five, .eight, .six, .four, .nine, .one, .seven],
//            [.nine, .eight, .six, .one, .seven, .three, .five, .two, .four],
//            [.one, .four, .seven, .five, .nine, .two, .eight, .three, .six]
//        ]
//    ]
    
    @EnvironmentObject var vM: ViewModel
    
    @State var selectedArea: AreaAndField = .zero
    @State var selectedField: AreaAndField = .zero
    @State var selectedValue: AreaAndField = .zero
    
    @State var selectedEntryType: EntryType = .normal
    
    @State var showSettings: Bool = false
    
    var btnFirstLine: [AreaAndField] = [.one, .two, .three, .four, .five]
    var btnSecondLine: [AreaAndField] = [.six, .seven, .eight, .nine, .zero]
    
    var body: some View {
        VStack {
            
            HStack {
                
                Button {
                    showSettings = true
                } label: {
                    Image(systemName: "gearshape")
                        .foregroundColor(Color.primary)
                        .frame(width: 25, height: 25)
                        .font(.callout)
                        .padding(8)
                        .background(Color("fieldBackground"))
                        .cornerRadius(25)
                        .overlay (
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                
                Spacer()
                
                StopWatchView()
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(Color("fieldBackground"))
                    .cornerRadius(25)
                    .overlay (
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                
                Spacer()
                
                Button {
                    vM.setNewLevel()
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(Color.primary)
                        .frame(width: 25, height: 25)
                        .font(.callout)
                        .padding(8)
                        .background(Color("fieldBackground"))
                        .cornerRadius(25)
                        .overlay (
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
            }
            .padding()

            Spacer()
            
            VStack(spacing: 0) {
                ForEach(0..<3) { i in
                    HStack(spacing: 0) {
                        ForEach(0..<3) { j in
                            Area(
                                roundedBorder:
                                    i == 0 && j == 0 ? [.topLeft] :
                                    i == 0 && j == 2 ? [.topRight] :
                                    i == 2 && j == 0 ? [.bottomLeft] :
                                    i == 2 && j == 2 ? [.bottomRight] : [],
                                einstiegDatas: vM.einstieg[i][j],
                                area: calculateArea(i: i, j: j),
                                selectedArea: $selectedArea,
                                selectedField: $selectedField,
                                selectedValue: $selectedValue
                            )
                            
                            
    //                        if i == 0 && j == 0 {
    //                            Area(
    //                                roundedBorder: [.topLeft],
    //                                einstiegDatas: vM.einstieg[i][j],
    //                                area: calculateArea(i: i, j: j),
    //                                selectedArea: $selectedArea,
    //                                selectedField: $selectedField,
    //                                selectedValue: $selectedValue
    //                            )
    //                        } else if i == 0 && j == 2 {
    //                            Area(
    //                                roundedBorder: [.topRight],
    //                                einstiegDatas: vM.einstieg[i][j],
    //                                area:  calculateArea(i: i, j: j),
    //                                selectedArea: $selectedArea,
    //                                selectedField: $selectedField,
    //                                selectedValue: $selectedValue
    //                            )
    //                        } else if i == 2 && j == 0 {
    //                            Area(
    //                                roundedBorder: [.bottomLeft],
    //                                einstiegDatas: vM.einstieg[i][j],
    //                                area: calculateArea(i: i, j: j),
    //                                selectedArea: $selectedArea,
    //                                selectedField: $selectedField,
    //                                selectedValue: $selectedValue
    //                            )
    //                        } else if i == 2 && j == 2 {
    //                            Area(
    //                                roundedBorder: [.bottomRight],
    //                                einstiegDatas: vM.einstieg[i][j],
    //                                area: calculateArea(i: i, j: j),
    //                                selectedArea: $selectedArea,
    //                                selectedField: $selectedField,
    //                                selectedValue: $selectedValue
    //                            )
    //                        } else {
    //                            Area(
    //                                einstiegDatas: vM.einstieg[i][j],
    //                                area: calculateArea(i: i, j: j),
    //                                selectedArea: $selectedArea,
    //                                selectedField: $selectedField,
    //                                selectedValue: $selectedValue
    //                            )
    //                        }
                            
                        }
                    }
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.gray, lineWidth: 5)
            )
            
            Spacer()
            
            Picker("EntryType", selection: $vM.normalOrCandidate) {
                Text("Normal").tag(EntryType.normal)
                Text("Candidate").tag(EntryType.candidate)
            }
            .pickerStyle(.segmented)
            .padding()
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    ForEach(Array(btnFirstLine.enumerated()), id: \.offset) { index, item in
                        SetValueBtnView(roundedBorder: index == 0 ? [.topLeft] : index == 4 ? [.topRight] : [], value: item)
                    }
                }
                HStack(spacing: 0) {
                    ForEach(Array(btnSecondLine.enumerated()), id: \.offset) { index, item in
                        SetValueBtnView(roundedBorder: index == 0 ? [.bottomLeft] : index == 4 ? [.bottomRight] : [], value: item)
                    }
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.primary, lineWidth: 3)
            )
        }
        .background(Color("viewBackground"))
        .sheet(isPresented: $showSettings) {
            Settings()
        }
        
    }
    
    func calculateArea(i: Int, j: Int) -> AreaAndField {
        return AreaAndField(rawValue: String(i * 3 + j)) ?? .zero
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}

enum EntryType: String {
    case normal = "Normal"
    case candidate = "Candidate"
}

enum AreaAndField: String, Hashable {
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


