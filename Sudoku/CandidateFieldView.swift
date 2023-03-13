//
//  CandidateFieldView.swift
//  Sudoku
//
//  Created by Hauke Marquard on 13.03.23.
//

import SwiftUI

struct CandidateFieldView: View {
    
    var area: AreaAndField
    var field: AreaAndField
    
    @State var values: [AreaAndField] = [.two, .seven, .five, .eight]
    
    @EnvironmentObject var vM: ViewModel
    
    var body: some View {
        VStack(spacing: -3) {
            HStack(spacing: 4) {
                Text(vM.getCandidates(area: area, field: field).contains(.one) ? "1" : "  ")
                Text(vM.getCandidates(area: area, field: field).contains(.two) ? "2" : "  ")
                Text(vM.getCandidates(area: area, field: field).contains(.three) ? "3" : "  ")
            }
            HStack(spacing: 5) {
                Text(vM.getCandidates(area: area, field: field).contains(.four) ? "4" : "  ")
                Text(vM.getCandidates(area: area, field: field).contains(.five) ? "5" : "  ")
                Text(vM.getCandidates(area: area, field: field).contains(.six) ? "6" : "  ")
            }
            HStack(spacing: 5) {
                Text(vM.getCandidates(area: area, field: field).contains(.seven) ? "7" : "  ")
                Text(vM.getCandidates(area: area, field: field).contains(.eight) ? "8" : "  ")
                Text(vM.getCandidates(area: area, field: field).contains(.nine) ? "9" : "  ")
            }
        }
        .font(.caption2)
        .foregroundColor(.secondary)
        .frame(width: 40, height: 40)
        .onAppear {
            values = vM.getCandidates(area: area, field: field)
        }
    }
}

struct CandidateFieldView_Previews: PreviewProvider {
    static var previews: some View {
        CandidateFieldView(area: .one, field: .two)
            .environmentObject(ViewModel())
    }
}
