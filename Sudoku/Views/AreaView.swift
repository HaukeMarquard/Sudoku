//
//  AreaView.swift
//  Sudoku
//
//  Created by Hauke Marquard on 29.01.23.
//

import SwiftUI

struct AreaView: View {
    
    var area: [Int]
    
    var body: some View {
        VStack {
            ForEach (area, id: \.self) { _ in
                HStack {
                    ForEach (area, id: \.self) { item in
                        Text("\(item)")
                    }
                }
            }
            
        }
    }
}

struct AreaView_Previews: PreviewProvider {
    static var previews: some View {
        AreaView(area: [1,2,3])
    }
}
