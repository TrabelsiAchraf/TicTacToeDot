//
//  GameTimer.swift
//  TicTacToeDot
//
//  Created by Achraf Trabelsi on 14/04/2022.
//

import Foundation
import Combine

class GameTimer: ObservableObject {
    @Published var timerStr: String = ""
    @Published var isGameOver: Bool = false
    
    static let partyTime = 180
    private var seconds = GameTimer.partyTime
    private var timer = Timer()
    
    // MARK: - Public
    
    init() {
        timerStr = timeString(time: TimeInterval(GameTimer.partyTime))
    }
    
    func start() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(GameTimer.updateTimer)), userInfo: nil, repeats: true)
    }
    
    func reset() {
        timer.invalidate()
        seconds = GameTimer.partyTime
        timerStr = timeString(time: TimeInterval(seconds))
    }
    
    // MARK: - Private
    
    @objc private func updateTimer() {
        seconds -= 1
        timerStr = timeString(time: TimeInterval(seconds))
    }
    
    private func timeString(time: TimeInterval) -> String {
        guard time > 0 else {
            timer.invalidate()
            seconds = GameTimer.partyTime
            isGameOver = true
            return "00:00"
        }
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
}
