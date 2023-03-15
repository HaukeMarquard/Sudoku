//
//  Settings.swift
//  Sudoku
//
//  Created by Hauke Marquard on 14.03.23.
//

import SwiftUI

struct Settings: View {
    
    @State var showWrongEntry: Bool = false
    @State var showSelectionLine: Bool = false
    @State var showArea: Bool = false
    
    @EnvironmentObject private var vM: ViewModel
    
    var body: some View {
        Form {
            Section("Hilfen") {
                Toggle("Show wrong entry", isOn: $vM.showWrongEntry)
                Toggle("Show selection line", isOn: $vM.showLine)
                Toggle("Show Area", isOn: $vM.showArea)
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
