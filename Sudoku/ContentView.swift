//
//  ContentView.swift
//  Sudoku
//
//  Created by Hauke Marquard on 28.01.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<3) { i in
                HStack(spacing: 0) {
                    ForEach(0..<3) { j in
                        if i == 0 && j == 0 {
                            Area(roundedBorder: [.topLeft])
                        } else if i == 0 && j == 2 {
                            Area(roundedBorder: [.topRight])
                        } else if i == 2 && j == 0 {
                            Area(roundedBorder: [.bottomLeft])
                        } else if i == 2 && j == 2 {
                            Area(roundedBorder: [.bottomRight])
                        } else {
                            Area()
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
