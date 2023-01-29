//
//  ViewModel.swift
//  Sudoku
//
//  Created by Hauke Marquard on 29.01.23.
//

import Foundation

class ViewModel: ObservableObject {
    
    @Published
    public var field = [
        [1,2,3,4,5,6,7,8,9],
        [1,2,3,4,5,6,7,8,9],
        [1,2,3,4,5,6,7,8,9],
        [1,2,3,4,5,6,7,8,9],
        [1,2,3,4,5,6,7,8,9],
        [1,2,3,4,5,6,7,8,9],
        [1,2,3,4,5,6,7,8,9],
        [1,2,3,4,5,6,7,8,9],
        [1,2,3,4,5,6,7,8,9]
    ]
    
}
