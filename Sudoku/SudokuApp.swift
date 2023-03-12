//
//  SudokuApp.swift
//  Sudoku
//
//  Created by Hauke Marquard on 28.01.23.
//

import SwiftUI

@main
struct SudokuApp: App {
    
    @StateObject var vM = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vM)
        }
    }
}
