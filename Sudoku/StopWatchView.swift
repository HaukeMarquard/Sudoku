//
//  StopWatchView.swift
//  Sudoku
//
//  Created by Hauke Marquard on 14.03.23.
//

import SwiftUI

struct StopWatchView: View {
    
    @StateObject private var stopWatchManager: StopWatchManager = StopWatchManager()
    
    @State private var playPauseIcon: String = "play.circle"
    
    var body: some View {
        HStack(spacing: 5) {
//            Text("\(String(stopWatchManager.minutesElapsed)):\(String(format: "%02.f", stopWatchManager.secondsElapsed))") // Um nur die Sekunden anzuzeigen: "1.f"
//                .font(.title3)
            HStack(spacing: 0) {
                DigitView(digit: Int(stopWatchManager.secondsElapsed / 60 / 10))
                DigitView(digit: Int(Int(stopWatchManager.secondsElapsed) / 60 % 10))
                Text(":")
                DigitView(digit: Int(Int(stopWatchManager.secondsElapsed) % 60 / 10))
                DigitView(digit: Int(Int(stopWatchManager.secondsElapsed) % 60 % 10))
                
            }
            .foregroundColor(Color.primary)
            
            Button {
                if stopWatchManager.mode == .running {
                    stopWatchManager.pause()
                        playPauseIcon = "play.circle"
                    
                } else {
                    stopWatchManager.start()
                        playPauseIcon = "pause.circle"
                }
            } label: {
                Image(systemName: playPauseIcon)
                    .foregroundColor(.primary)
                    .font(.callout).bold()
            }
        }
        .onAppear {
            stopWatchManager.start()
            playPauseIcon = "pause.circle"
        }
    }
}

struct StopWatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopWatchView()
    }
}

struct DigitView: View {
    let digit: Int
    
    var body: some View {
        Text(String(digit))
            .frame(width: 12, height: 25)
            .font(.callout).bold()
//            .background(Color.white)
            .cornerRadius(4)
//            .overlay(
//                RoundedRectangle(cornerRadius: 4)
//                    .stroke(Color.gray, lineWidth: 2)
//            )
    }
}
