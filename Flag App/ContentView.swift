//
//  ContentView.swift
//  Flag App
//
//  Created by Pete Nealley on 1/3/25.
//

import SwiftUI

var remainingCountryCodes: [String] = Locale.Region.isoRegions.filter {$0.subRegions.isEmpty}.map {$0.identifier}
var currentQuizCountryCodes = populateQuizFlagCodesArray(allRemainingCountryCodes: remainingCountryCodes)
var correctAnswerCountryCode = pickCorrectAnswer(anArray: currentQuizCountryCodes)

struct ContentView: View {
    @State var gameOver: Bool = false
    @State var leftFlagCountryCode = currentQuizCountryCodes[0]
    @State var centerFlagCountryCode = currentQuizCountryCodes[1]
    @State var rightFlagCountryCode = currentQuizCountryCodes[2]
    @State var leftFlag = generateCountryFlag(currentQuizCountryCodes[0])
    @State var centerFlag = generateCountryFlag(currentQuizCountryCodes[1])
    @State var rightFlag = generateCountryFlag(currentQuizCountryCodes[2])
    @State var correctAnswer = generateCountryName(correctAnswerCountryCode)
    @State var currentScore = 0
    @State var correctAnswers = 0
    @State var wrongAnswers = 0
    
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
                            correctAnswers += 1
                            //Send Message - you got it right
                            print("Correct Answer = \(correctAnswerCountryCode)")
                            remainingCountryCodes = removeCorrectAnswer(anArray: remainingCountryCodes, correctCountryCode: correctAnswerCountryCode)
                            print("Remaining Country Count: \(remainingCountryCodes.count)")
                        } else {
                            wrongAnswers += 1
                            print("Wrong Answer = \(leftFlagCountryCode)")
                            print("Remaining Country Count: \(remainingCountryCodes.count)")
                        }
                        currentQuizCountryCodes = populateQuizFlagCodesArray(allRemainingCountryCodes: remainingCountryCodes)
                        let test = currentQuizCountryCodes
                        leftFlag = generateCountryFlag(test[0])
                        leftFlagCountryCode = test[0]
                        centerFlag = generateCountryFlag(test[1])
                        centerFlagCountryCode = test[2]
                        rightFlag = generateCountryFlag(test[2])
                        rightFlagCountryCode = test[2]
                        correctAnswerCountryCode = pickCorrectAnswer(anArray: currentQuizCountryCodes)
                        correctAnswer = generateCountryName(correctAnswerCountryCode)
                    } label: {
                        Text(leftFlag)
                            .font(.system(size: 300))
                            .padding(.vertical, -55)
                            .padding(.horizontal, 5)
                            .background(.black.opacity(0.5))
                            .cornerRadius(40)
                    }
                    //centerFlag
                    Button {
                        if centerFlagCountryCode == correctAnswerCountryCode {
                            correctAnswers += 1
                            //Send Message - you got it right
                            print("Correct Answer = \(correctAnswerCountryCode)")
                            remainingCountryCodes = removeCorrectAnswer(anArray: remainingCountryCodes, correctCountryCode: correctAnswerCountryCode)
                            print("Remaining Country Count: \(remainingCountryCodes.count)")
                        } else {
                            wrongAnswers += 1
                            print("Wrong Answer = \(centerFlagCountryCode)")
                        }
                        currentQuizCountryCodes = populateQuizFlagCodesArray(allRemainingCountryCodes: remainingCountryCodes)
                        let test = currentQuizCountryCodes
                        leftFlag = generateCountryFlag(test[0])
                        leftFlagCountryCode = test[0]
                        centerFlag = generateCountryFlag(test[1])
                        centerFlagCountryCode = test[2]
                        rightFlag = generateCountryFlag(test[2])
                        rightFlagCountryCode = test[2]
                        correctAnswerCountryCode = pickCorrectAnswer(anArray: currentQuizCountryCodes)
                        correctAnswer = generateCountryName(correctAnswerCountryCode)
                    } label: {
                        Text(centerFlag)
                            .font(.system(size: 300))
                            .padding(.vertical, -55)
                            .padding(.horizontal, 5)
                            .background(.black.opacity(0.5))
                            .cornerRadius(40)
                    }
                    
                    //rightFlag
                    Button {
                        if rightFlagCountryCode == correctAnswerCountryCode {
                            correctAnswers += 1
                            //Send Message - you got it right
                            print("Correct Answer = \(correctAnswerCountryCode)")
                            remainingCountryCodes = removeCorrectAnswer(anArray: remainingCountryCodes, correctCountryCode: correctAnswerCountryCode)
                            print("Remaining Country Count: \(remainingCountryCodes.count)")
                        } else {
                            wrongAnswers += 1
                            print("Wrong Answer = \(rightFlagCountryCode)")
                        }
                        currentQuizCountryCodes = populateQuizFlagCodesArray(allRemainingCountryCodes: remainingCountryCodes)
                        let test = currentQuizCountryCodes
                        leftFlag = generateCountryFlag(test[0])
                        leftFlagCountryCode = test[0]
                        centerFlag = generateCountryFlag(test[1])
                        centerFlagCountryCode = test[2]
                        rightFlag = generateCountryFlag(test[2])
                        rightFlagCountryCode = test[2]
                        correctAnswerCountryCode = pickCorrectAnswer(anArray: currentQuizCountryCodes)
                        correctAnswer = generateCountryName(correctAnswerCountryCode)
                    } label: {
                        Text(rightFlag)
                            .font(.system(size: 300))
                            .padding(.vertical, -55)
                            .padding(.horizontal, 5)
                            .background(.black.opacity(0.5))
                            .cornerRadius(40)
                    }
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
                        gameOver.toggle()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    .font(.largeTitle)
                    .padding()
                    .disabled(gameOver)
                    
                    //Pause Button
                    Button("Pause") {
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.yellow)
                    .font(.largeTitle)
                    .padding()
                    .disabled(!gameOver)
                    
                    //End Button
                    Button("End") {
                        gameOver.toggle()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                    .font(.largeTitle)
                    .padding()
                    .disabled(!gameOver)
                }
                .foregroundColor(.white)
                .fontWeight(.bold)
                
                //                Spacer()
                
                //Score Info
                HStack {
                    
                    //Timer
                    
                    VStack {
                        //Current Score
                        Text("Current Score:  \(currentScore)%")
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
