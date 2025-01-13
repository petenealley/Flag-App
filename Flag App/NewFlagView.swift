//
//  NewFlagView.swift
//  Flag App
//
//  Created by Pete Nealley on 1/12/25.
//
import SwiftUI

struct NewFlagView: View {
    @StateObject private var viewModel = FlagViewModel(
        countryCodes: Array(Locale.Region.isoRegions.filter { $0.subRegions.isEmpty }.map { $0.identifier })
    )
    
    let timerObject = TimerObject(timerColor: .indigo, length: 120)
    
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
                                viewModel.checkAnswer(countryCode)
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {}
                        } label: {
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
                                .disabled(viewModel.gameOver)
                        }
                    }
                }
                
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
                        TimerView(timerObject: timerObject, controls: true)
                            .frame(width: 200)
                            .padding(.leading, 0)
                            .padding(.bottom, 40)
                    }
                    
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
//                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding(.leading, 50)
                    
                    VStack {
                        //High Score
                        
                        //Music On/Off Switch
                        HStack {
                            //Music Icon On
                            
                            //Switch
                            
                            //Music Icon Off
                        }
                    }
                }
                
            }
            .foregroundColor(.black)
        }
        //Alert Message Management (on ZStack)
        .alert(viewModel.scoreTitle, isPresented: $viewModel.showingScore) {
            if viewModel.scoreTitle == "Game Over!" {
                Button("New Game", action: viewModel.startNewGame)
            } else {
                Button("Continue", action: viewModel.startNewRound)
            }
        } message: {
            Text(viewModel.scoreMessage)
        }
    }
}

#Preview (traits: .landscapeRight) {
    NewFlagView()
}
