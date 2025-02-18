//
//  NewFlagView.swift
//  Flag App
//
//  Created by Paul Jordan on 1/12/25.
//
import SwiftUI
import AVKit

struct NewFlagView: View {
    @State private var viewModel = FlagViewModel(
        countryCodes: Array(Locale.Region.isoRegions.filter { $0.subRegions.isEmpty }.map { $0.identifier })
    )
    
    @State var isMusicOn = true
    @State var count = 1
    
    @Environment(TimerObject.self) var timerObject
    let controls = true
    @State private var width: CGFloat = 0
    
    var body: some View {
        ZStack {
            //Background Image
            Image(.parchmenthoriz)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack {
                //Main Title
                Text("Ha Yool's Flag Quiz")
                    .font(.system(size: 72))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .tracking(5)
                    .padding(.top, 30)
                
                Spacer()
                
                //Flags
                HStack {
                    ForEach(viewModel.currentQuizFlagCodes, id: \.self) { countryCode in
                        Button {
                            withAnimation {
                                viewModel.checkAnswer(countryCode, remainingTime: timerObject.remainingTime)
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {}

                            if timerObject.remainingTime == 0 {
                                viewModel.gamePaused = true
                                
                            }
                        }
                        label: {
                            Text(viewModel.generateCountryFlag(for: countryCode))
                                .font(.system(size: 300))
                                .padding(.vertical, -55)
                                .padding(.horizontal, 5)
                                .background(.black.opacity(0.5))
                                .cornerRadius(40)
                                .rotation3DEffect(
                                    .degrees(viewModel.selectedFlag == countryCode ? viewModel.rotationAmount : 0),
                                    axis: (x: 0, y: 1, z: 0)
                                )
                        }
                    }
                }
                .disabled(viewModel.gamePaused)
                
                //Challenge
                HStack {
                    //Quiz Question
                    Text("Which one is the flag of")
                    
                    //Quiz Country
                    Text(viewModel.generateCountryName(for: viewModel.correctCountryCode))
                        .foregroundStyle(.red)
                    
                    //Question Mark
                    Text("?")
                }
                .font(.system(size: 48))
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                //Timer + Score Info + Music & High Score
                HStack {
                    
                    //Timer
                    VStack {
                        //Controls
                        if controls {
                            HStack {
                                //Start Button
                                Button {
                                    viewModel.gamePaused = false
                                    timerObject.startTimer()
                                    
                                    if isMusicOn {
                                        //start music playing here
                                        playSound(sound: "song1", type: "mp3")
                                    }
                                    
                                } label: {
                                    Image(systemName: "play.fill")
                                }
                                .modifier(ControlButtonStyle(color: timerObject.timerColor, disabled: timerObject.playButtonDisabled))
                                
                                //Pause Button
                                Button {
                                    viewModel.gamePaused = true
                                    timerObject.stopTimer()
                                    
                                    if isMusicOn {
                                        //pause music playing here
                                        audioPlayer?.pause()
                                    }
                                    
                                } label: {
                                    Image(systemName: "pause.fill")
                                }
                                .modifier(ControlButtonStyle(color: timerObject.timerColor, disabled: timerObject.pauseButtonDisabled))
                                
                                //Reset Button
                                Button {
                                    timerObject.resetTimer()
                                    viewModel.startNewGame()
                                } label: {
                                    Image(systemName: "gobackward")
                                }
                                .modifier(ControlButtonStyle(color: timerObject.timerColor, disabled: timerObject.resetButtonDisabled))
                            }
                        }
                        //Timer Countdown Circle
                        ZStack {
                            Circle()
                                .stroke(lineWidth: width / 10)
                                .foregroundStyle(timerObject.timerColor.opacity(0.4))
                            Circle()
                                .trim(from: 0.0, to: min(1-timerObject.progress, 1.0))
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
                    .padding(.leading, 0)
                    .padding(.bottom, 40)
                    
                    //Score Info
                    VStack {
                        //Current Score
                        Text("Current Score:  \(viewModel.score)")
                            .font(.largeTitle)
                            .padding(.top)
                            .padding(.bottom)
                            .fontWeight(.bold)
                        
                        //Number of Correct Guesses
                        Text("Correct Guesses:  \(viewModel.correctAnswers)")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        //Number of Incorrect Guesses
                        Text("Incorrect Guesses:  \(viewModel.wrongAnswers)")
                            .font(.title)
                            .padding(.bottom)
                            .fontWeight(.bold)
                    }
                    .frame(width: 400)
                    .background(.indigo.opacity(0.9))
                    .cornerRadius(20)
                    .foregroundColor(.white)
                    .padding(.leading, 50)
                    
                    VStack {
                        //High Score
                        VStack {
                            Text("High Score:  \(viewModel.highScore)")
                                .font(.title)
                                .padding()
                                .fontWeight(.bold)
                        }
                        .frame(width: 250)
                        .background(.green.opacity(1))
                        .cornerRadius(20)
                        .foregroundColor(.white)
                        .padding(.leading, 50)
                        
                        
                        //Game Settings Panel
                        HStack {
                            //Music On/Off Icon
                            Toggle("Music", systemImage: isMusicOn ? "speaker.circle" : "speaker.slash.circle", isOn: $isMusicOn)
                                .tint(.white.opacity(0.0))
                                .font(.system(size: 60))
                                .padding()
                                .toggleStyle(.button)
                                .contentTransition(.symbolEffect)
                                .labelStyle(.iconOnly)
                                .onTapGesture {
                                    isMusicOn.toggle()
                                    if !isMusicOn {
//stop music palying here
                                    }
                                }
                            
                            //Timer Icon/Slder
                            
                        }
                        .frame(width: 250)
                        .background(.white)
                        .cornerRadius(20)
                        .foregroundColor(.black)
                        .padding(.leading, 50)
            

                    }

                }
                
            }
            .foregroundColor(.black)
            .onAppear(perform: {
                
            })
        }
        //Alert Message Management (on ZStack)
        .alert(viewModel.scoreTitle, isPresented: $viewModel.showingScore) {
            if viewModel.scoreTitle == "Game Over!" {
                Button("Game Over", action: viewModel.gameOver)
            } else {
                Button("Continue", action: viewModel.startNewRound)
            }
        } message: {
            Text(viewModel.scoreMessage)
        }
    }
        
    func displayTime(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%01d:%02d", minutes, seconds)
    }
    
}

#Preview (traits: .landscapeRight) {
    NewFlagView()
        .environment(TimerObject(timerColor: .indigo, length: 120))
}

struct ControlButtonStyle: ViewModifier {
    let color: Color
    let disabled: Bool
    func body(content: Content) -> some View {
        content.font(.title)
            .bold()
            .frame(width: 75, height: 75)
            .background(.red).opacity(disabled ? 0.5 : 1)
            .foregroundStyle(.white)
            .clipShape(Circle())
            .disabled(disabled)
    }
}
