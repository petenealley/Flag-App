//
//  ContentView.swift
//  Flag App
//
//  Created by Pete Nealley on 1/3/25.
//

import SwiftUI

var correctAnswers = 0
var wrongAnswers = 0
var currentScore = 0

struct ContentView: View {
    
    @State var gameOver: Bool = true
    @State var leftFlagCountryCode = currentQuizCountryCodes[0]
    @State var centerFlagCountryCode = currentQuizCountryCodes[1]
    @State var rightFlagCountryCode = currentQuizCountryCodes[2]
    @State var leftFlag = generateCountryFlag(currentQuizCountryCodes[0])
    @State var centerFlag = generateCountryFlag(currentQuizCountryCodes[1])
    @State var rightFlag = generateCountryFlag(currentQuizCountryCodes[2])
    @State var correctAnswer = generateCountryName(correctAnswerCountryCode)
    
    func pickedCorrectAnswer() {
        correctAnswers += 1
        //Send Message - you got it right
        print("Correct Answer = \(generateCountryName(correctAnswerCountryCode))")
        remainingCountryCodes = removeCorrectAnswer(anArray: remainingCountryCodes, correctCountryCode: correctAnswerCountryCode)
        print("Remaining Country Count: \(remainingCountryCodes.count)")
        currentQuizCountryCodes = populateQuizFlagCodesArray(allRemainingCountryCodes: remainingCountryCodes)
        let test = currentQuizCountryCodes
        leftFlag = generateCountryFlag(test[0])
        leftFlagCountryCode = test[0]
        centerFlag = generateCountryFlag(test[1])
        centerFlagCountryCode = test[1]
        rightFlag = generateCountryFlag(test[2])
        rightFlagCountryCode = test[2]
        correctAnswerCountryCode = pickCorrectAnswer(anArray: currentQuizCountryCodes)
        correctAnswer = generateCountryName(correctAnswerCountryCode)
        print(currentQuizFlagCodes)
    }
    
    func pickedWrongAnswer(answer: String) {
        wrongAnswers += 1
        print("Wrong Answer = \(generateCountryName(answer))")
        print("Remaining Country Count: \(remainingCountryCodes.count)")
        currentQuizCountryCodes = populateQuizFlagCodesArray(allRemainingCountryCodes: remainingCountryCodes)
        let test = currentQuizCountryCodes
        leftFlag = generateCountryFlag(test[0])
        leftFlagCountryCode = test[0]
        centerFlag = generateCountryFlag(test[1])
        centerFlagCountryCode = test[1]
        rightFlag = generateCountryFlag(test[2])
        rightFlagCountryCode = test[2]
        correctAnswerCountryCode = pickCorrectAnswer(anArray: currentQuizCountryCodes)
        correctAnswer = generateCountryName(correctAnswerCountryCode)
        print(currentQuizFlagCodes)
    }
    
    func playGame() {
        while totalRemainingCountries > 250 {
            gameOver = false
        }
        gameOver = true
    }
    
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
                    //leftFlag
                    Button {
                        if leftFlagCountryCode == correctAnswerCountryCode {
                            pickedCorrectAnswer()
                        } else {
                            pickedWrongAnswer(answer: leftFlagCountryCode)
                        }
                        currentScore = (correctAnswers-wrongAnswers) * 10
                    } label: {
                        Text(leftFlag)
                            .font(.system(size: 300))
                            .padding(.vertical, -55)
                            .padding(.horizontal, 5)
                            .background(.black.opacity(0.5))
                            .cornerRadius(40)
                    }
                    .disabled(gameOver)
                    //centerFlag
                    Button {
                        
                        if centerFlagCountryCode == correctAnswerCountryCode {
                            pickedCorrectAnswer()
                        } else {
                            pickedWrongAnswer(answer: centerFlagCountryCode)
                        }
                        currentScore = (correctAnswers-wrongAnswers) * 10
                    }
                    label: {
                        Text(centerFlag)
                            .font(.system(size: 300))
                            .padding(.vertical, -55)
                            .padding(.horizontal, 5)
                            .background(.black.opacity(0.5))
                            .cornerRadius(40)
                    }
                    .disabled(gameOver)
                    //rightFlag
                    Button {
                            if rightFlagCountryCode == correctAnswerCountryCode {
                                pickedCorrectAnswer()
                            } else {
                                pickedWrongAnswer(answer: rightFlagCountryCode)
                            }
                        currentScore = (correctAnswers-wrongAnswers) * 10
                    } label: {
                        Text(rightFlag)
                            .font(.system(size: 300))
                            .padding(.vertical, -55)
                            .padding(.horizontal, 5)
                            .background(.black.opacity(0.5))
                            .cornerRadius(40)
                    }
                    .disabled(gameOver)
                }
                
                //Challenge
                HStack {
                    //Quiz Question
                    Text("Which one is the flag of")
                    
                    //Quiz Country
                    Text(correctAnswer)
                        .foregroundStyle(.red)
                    
                    //Question Mark
                    Text("?")
                }
                .font(.system(size: 48))
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                //Buttons to Start Pause & Stop
                HStack {
                    //Start Button
                    Button("Start") {
                        gameOver = false
//                        playGame()
                        print(remainingCountryCodes)
                        print(currentQuizFlagCodes)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    .font(.largeTitle)
                    .padding()
                    .disabled(!gameOver)
                    
//                    //Pause Button
//                    Button("Pause") {
//                    }
//                    .buttonStyle(.borderedProminent)
//                    .tint(.yellow)
//                    .font(.largeTitle)
//                    .padding()
//                    .disabled(gameOver)
                    
                    //End Button
                    Button("End") {
                        gameOver = true
                        print("gameOver = \(gameOver)")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                    .font(.largeTitle)
                    .padding()
                    .disabled(gameOver)
                }
                .foregroundColor(.white)
                .fontWeight(.bold)
                
                //                Spacer()
                
                //Score Info
                HStack {
                    
                    //Timer
                    
                    VStack {
                        //Current Score
                        Text("Current Score:  \(currentScore)")
                            .font(.largeTitle)
                            .padding(.top)
                            .padding(.bottom)
                            .fontWeight(.bold)
                        
                        
                        //Number of Correct Guesses
                        Text("Correct Guesses:  \(correctAnswers)")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        
                        //Number of Incorrect Guesses
                        Text("Incorrect Guesses:  \(wrongAnswers)")
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

#Preview(traits: .landscapeLeft) {
    ContentView()
}
