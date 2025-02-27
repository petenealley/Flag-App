//
//  TimerView.swift
//  Flag App
//
//  Created by Paul Jordan on 2/26/25.
//

import SwiftUI

struct TimerView: View {
    @Environment(TimerObject.self) var timerObject
    @Binding var width: CGFloat
    @Binding var gamePaused: Bool
    @Binding var isMusicOn: Bool
    var musicPlayer: MusicPlayer
    var onReset: () -> Void
    let controls: Bool  // Added controls parameter
    
    var body: some View {
        VStack {
            if controls {
                HStack {
                    Button {
                        gamePaused = false
                        timerObject.startTimer()
                        if isMusicOn {
                            musicPlayer.playSong()
                        }
                    } label: {
                        Image(systemName: "play.fill")
                    }
                    .modifier(ControlButtonStyle(color: timerObject.timerColor, disabled: timerObject.playButtonDisabled))
                    
                    Button {
                        gamePaused = true
                        timerObject.stopTimer()
                        musicPlayer.pauseSong()
                    } label: {
                        Image(systemName: "pause.fill")
                    }
                    .modifier(ControlButtonStyle(color: timerObject.timerColor, disabled: timerObject.pauseButtonDisabled))
                    
                    Button {
                        onReset()
                    } label: {
                        Image(systemName: "gobackward")
                    }
                    .modifier(ControlButtonStyle(color: timerObject.timerColor, disabled: timerObject.resetButtonDisabled))
                }
            }
            ZStack {
                Circle()
                    .stroke(lineWidth: width / 10)
                    .foregroundStyle(timerObject.timerColor.opacity(0.4))
                Circle()
                    .trim(from: 0.0, to: min(1 - timerObject.progress, 1.0))
                    .stroke(timerObject.timerColor.gradient, style: StrokeStyle(
                        lineWidth: width / 10,
                        lineCap: .round,
                        lineJoin: .miter))
                    .rotationEffect(.degrees(-90))
                    .shadow(radius: 2)
                Circle()
                    .stroke(lineWidth: width / 20)
                    .foregroundStyle(Color(uiColor: .systemBackground))
                    .shadow(color: timerObject.timerColor.opacity(0.6), radius: 5)
                    .frame(width: width / 8)
                    .offset(x: -width / 1.87)
                    .rotationEffect(.degrees(90.0 - 360 * timerObject.progress))
                VStack {
                    Text(displayTime(timerObject.length))
                        .monospacedDigit()
                        .font(.system(size: width / 12))
                    Text(displayTime(timerObject.remainingTime))
                        .monospacedDigit()
                        .font(.system(size: width / 3))
                }
                .foregroundStyle(timerObject.timerColor)
                .bold()
                .contentTransition(.numericText())
            }
            .readSize { size in
                width = size.width
            }
            .padding(width / 8)
            .animation(.linear, value: timerObject.remainingTime)
        }
        .frame(width: 200)
        .padding(.bottom, 40)
    }
    
    private func displayTime(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%01d:%02d", minutes, seconds)
    }
}

// Custom button style defined here
struct ControlButtonStyle: ViewModifier {
    let color: Color
    let disabled: Bool
    
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundColor(disabled ? .gray : color)
            .disabled(disabled)
    }
}
