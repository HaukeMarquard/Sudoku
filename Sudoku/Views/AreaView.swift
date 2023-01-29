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
            HStack {
                Text("\(area[0])")
                    .frame(width: 30, height: 30)
                    .border(.gray)
                Text("\(area[1])")
                    .frame(width: 30, height: 30)
                    .border(.gray)
                Text("\(area[2])")
                    .frame(width: 30, height: 30)
                    .border(.gray)
            }
            HStack {
                Text("\(area[3])")
                    .frame(width: 30, height: 30)
                    .border(.gray)
                Text("\(area[4])")
                    .frame(width: 30, height: 30)
                    .border(.gray)
                Text("\(area[5])")
                    .frame(width: 30, height: 30)
                    .border(.gray)
            }
            HStack {
                Text("\(area[6])")
                    .frame(width: 30, height: 30)
                    .border(.gray)
                Text("\(area[7])")
                    .frame(width: 30, height: 30)
                    .border(.gray)
                Text("\(area[8])")
                    .frame(width: 30, height: 30)
                    .border(.gray)
            }
        }
    }
}

struct AreaView_Previews: PreviewProvider {
    static var previews: some View {
        AreaView(area: [7,5,6,4,9,3,1,8,2])
    }
}
