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
                
                
                //New Flags
                HStack {
                    ForEach(viewModel.currentQuizFlagCodes, id: \.self) { countryCode in
                        Button {
                            withAnimation {
                                viewModel.checkAnswer(countryCode)
                            }
                        } label: {
                            Text(viewModel.generateCountryFlag(for: countryCode))
                                .font(.system(size: 100))
                                .rotation3DEffect(
                                    .degrees(viewModel.selectedFlag == countryCode ? viewModel.rotationAmount : 0),
                                    axis: (x: 0, y: 1, z: 0)
                                )
//                                .opacity(viewModel.selectedFlag == nil || viewModel.selectedFlag == countryCode ? 1 : 0.25)
//                                .scaleEffect(viewModel.selectedFlag == nil || viewModel.selectedFlag == countryCode ? 1 : 0.8)
                        }
                    }
                }
                
                //Flags
                //                HStack {
                //                    //leftFlag
                //                    Button {
                //                        if leftFlagCountryCode == correctAnswerCountryCode {
                //                            pickedCorrectAnswer()
                //                        } else {
                //                            pickedWrongAnswer(answer: leftFlagCountryCode)
                //                        }
                //                        currentScore = (correctAnswers-wrongAnswers) * 10
                //                    } label: {
                //                        Text(leftFlag)
                //                            .font(.system(size: 300))
                //                            .padding(.vertical, -55)
                //                            .padding(.horizontal, 5)
                //                            .background(.black.opacity(0.5))
                //                            .cornerRadius(40)
                //                    }
                //                    .disabled(gameOver)
                //                    //centerFlag
                //                    Button {
                //
                //                        if centerFlagCountryCode == correctAnswerCountryCode {
                //                            pickedCorrectAnswer()
                //                        } else {
                //                            pickedWrongAnswer(answer: centerFlagCountryCode)
                //                        }
                //                        currentScore = (correctAnswers-wrongAnswers) * 10
                //                    }
                //                    label: {
                //                        Text(centerFlag)
                //                            .font(.system(size: 300))
                //                            .padding(.vertical, -55)
                //                            .padding(.horizontal, 5)
                //                            .background(.black.opacity(0.5))
                //                            .cornerRadius(40)
                //                    }
                //                    .disabled(gameOver)
                //                    //rightFlag
                //                    Button {
                //                            if rightFlagCountryCode == correctAnswerCountryCode {
                //                                pickedCorrectAnswer()
                //                            } else {
                //                                pickedWrongAnswer(answer: rightFlagCountryCode)
                //                            }
                //                        currentScore = (correctAnswers-wrongAnswers) * 10
                //                    } label: {
                //                        Text(rightFlag)
                //                            .font(.system(size: 300))
                //                            .padding(.vertical, -55)
                //                            .padding(.horizontal, 5)
                //                            .background(.black.opacity(0.5))
                //                            .cornerRadius(40)
                //                    }
                //                    .disabled(gameOver)
                //                }
                
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
                
                //                //Buttons to Start Pause & Stop
                //                HStack {
                //                    //Start Button
                //                    Button("Start") {
                //                        gameOver = false
                ////                        playGame()
                //                        print(remainingCountryCodes)
                //                        print(currentQuizFlagCodes)
                //                    }
                //                    .buttonStyle(.borderedProminent)
                //                    .tint(.green)
                //                    .font(.largeTitle)
                //                    .padding()
                //                    .disabled(!gameOver)
                //
                ////                    //Pause Button
                ////                    Button("Pause") {
                ////                    }
                ////                    .buttonStyle(.borderedProminent)
                ////                    .tint(.yellow)
                ////                    .font(.largeTitle)
                ////                    .padding()
                ////                    .disabled(gameOver)
                //
                //                    //End Button
                //                    Button("End") {
                //                        gameOver = true
                //                        print("gameOver = \(gameOver)")
                //                    }
                //                    .buttonStyle(.borderedProminent)
                //                    .tint(.red)
                //                    .font(.largeTitle)
                //                    .padding()
                //                    .disabled(gameOver)
                //                }
                //                .foregroundColor(.white)
                //                .fontWeight(.bold)
                
                //                Spacer()
                
                //Score Info
                HStack {
                    
                    //Timer
                    
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
                    //                .frame(alignment: .leading)
                    .background(.indigo.opacity(0.9))
                    .cornerRadius(20)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    
                    //Music On/Off Switch
                    HStack {
                        //Music Icon On
                        
                        //Switch
                        
                        //Music Icon Off
                    }
                    
                }
                
                
                Spacer()
                
            }
            .foregroundColor(.black)
        }
    }
}

#Preview {
    NewFlagView()
}
