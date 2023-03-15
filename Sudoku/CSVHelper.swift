//
//  CSVHelper.swift
//  Sudoku
//
//  Created by Hauke Marquard on 14.03.23.
//

import Foundation

class CSVHelper {
    
    typealias saveFormat = [[[AreaAndField]]]
    
    func getCSVData() -> Array<String> {
        do {
            let content = try String(contentsOfFile: "./quotes.csv")
            let parsedCSV: [String] = content.components(
                separatedBy: "\n"
            ).map{ $0.components(separatedBy: ",")[0] };
            return parsedCSV
        }
        catch {
            return []
        }
    }
    
}
