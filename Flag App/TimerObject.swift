//
//  TimerObject.swift
//  Timer App
//
//  Created by Paul Jordan on 1/12/25.
//

import SwiftUI

@Observable
class TimerObject {
    let timerColor: Color
    let length: Int
    
    init(timerColor: Color, length: Int) {
        self.timerColor = timerColor
        self.length = length
    }
    
    var timer: Timer? = nil
    var timeElapsed = 0
    
    var isTimerRunning = false
    
    var remainingTime: Int {
        length - timeElapsed
    }
    
    var progress: CGFloat {
        CGFloat(length - remainingTime) / CGFloat(length)
    }
    
    func startTimer() {
        isTimerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] _ in
            if remainingTime > 0 {
                timeElapsed += 1
            } else {
                stopTimer()
            }
        }
    }
    
    func stopTimer() {
        if isTimerRunning {
            isTimerRunning = false
            timer?.invalidate()
        }
    }
    
    func resetTimer(){
        timeElapsed = 0
        isTimerRunning = false
    }
    
    var playButtonDisabled: Bool {
        guard remainingTime > 0, !isTimerRunning else { return true }
        return false
    }
    
    var pauseButtonDisabled: Bool {
        guard remainingTime > 0, isTimerRunning else { return true }
        return false
    }
    
    var resetButtonDisabled: Bool {
        guard remainingTime != length, !isTimerRunning else { return true }
        return false
    }
}
