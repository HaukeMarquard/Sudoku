//
//  ContentView.swift
//  Sudoku
//
//  Created by Hauke Marquard on 28.01.23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm: ViewModel = ViewModel()
    @State private var liste = [1,2,3]
    
    var body: some View {
        VStack {
            ForEach (liste, id: \.self) { _ in
                HStack {
                    ForEach (liste, id: \.self) { _ in
                        AreaView(area: liste)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
