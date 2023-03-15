//
//  StopWatchManager.swift
//  Sudoku
//
//  Created by Hauke Marquard on 14.03.23.
//

import Foundation
import SwiftUI

class StopWatchManager: ObservableObject {
    
    enum stopWatchMode {
        case running, stopped, paused
    }
    @Published var mode: stopWatchMode = .stopped
    @Published var secondsElapsed = 0.0
    @Published var minutesElapsed = 0
    var timer = Timer()
    
    func start() {
        mode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.secondsElapsed += 0.1
        }
    }
    
    func pause() {
        mode = .paused
        timer.invalidate()
    }
    
    func stop() {
        mode = .stopped
        timer.invalidate()
        secondsElapsed = 0
    }
}


