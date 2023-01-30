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
        
        VStack(spacing: 0) {
            ForEach (vm.field, id: \.self) { i in
                HStack(spacing: 0) {
                    ForEach (i, id: \.self) { j in
                        AreaView(area: j)
                            .border(.black)
                            .ignoresSafeArea(.all)
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
