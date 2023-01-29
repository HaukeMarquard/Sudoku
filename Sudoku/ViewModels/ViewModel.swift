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
        [
            [7,5,6,4,9,3,1,8,2],
            [8,1,9,2,6,5,3,4,7],
            [3,2,4,7,1,8,9,6,5]
        ],
        [
            [5,4,1,3,7,9,6,2,8],
            [6,3,8,4,5,2,7,9,1],
            [2,7,9,6,8,1,4,5,3]
        ],
        [
            [2,3,5,8,6,4,9,1,7],
            [9,8,6,1,7,3,5,2,4],
            [1,4,7,5,9,2,8,3,6]
        ]
    ]
    
}
