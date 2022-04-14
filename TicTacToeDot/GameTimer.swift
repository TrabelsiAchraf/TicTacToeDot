//
//  GameTimer.swift
//  TicTacToeDot
//
//  Created by Achraf Trabelsi on 14/04/2022.
//

import Foundation
import Combine

class GameTimer: ObservableObject {
    @Published var timerStr: String = "03:00"
    
    private var seconds = 180
    private var timer = Timer()
    
    // MARK: - Public
    
    func start() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(GameTimer.updateTimer)), userInfo: nil, repeats: true)
    }
    
    func reset() {
        timer.invalidate()
        seconds = 180
        timerStr = timeString(time: TimeInterval(seconds))
    }
    
    // MARK: - Private
    
    @objc private func updateTimer() {
        seconds -= 1
        timerStr = timeString(time: TimeInterval(seconds))
    }
    
    private func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
}
