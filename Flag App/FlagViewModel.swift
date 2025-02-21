//
//  FlagViewModel.swift
//  Flag App
//
//  Created by Paul Jordan on 1/5/25.
//

import Foundation
import SwiftUI

@Observable
class FlagViewModel {
    
    // MARK: - Published Properties
    private(set) var currentQuizFlagCodes: [String] = []
    private(set) var correctCountryCode: String = ""
    private(set) var remainingCountryCodes: [String] = []
    private(set) var score = 0
    private(set) var correctAnswers = 0
    private(set) var wrongAnswers = 0
    var highScore = UserDefaults.standard.integer(forKey: "HighScore")
    var showingScore = false
    var scoreTitle = ""
    var scoreMessage = ""
    var rotationAmount = 0.0
    var selectedFlag: String?
    var gamePaused = true
    
    // MARK: - Private Properties
    private let allCountryCodes: [String]
    
    // MARK: - Initialization
    init(countryCodes: [String]) {
        self.allCountryCodes = countryCodes
        self.remainingCountryCodes = countryCodes
        startNewGame()
    }
    
    // MARK: - Public Methods
    
    func resetHighScore() {
        highScore = 0
        UserDefaults.standard.set(highScore, forKey: "HighScore")
    }
    
    func startNewGame() {
        gamePaused = true
        score = 0
        correctAnswers = 0
        wrongAnswers = 0
        remainingCountryCodes = allCountryCodes
        startNewRound()
    }
    
    func startNewRound() {
            currentQuizFlagCodes = populateQuizFlagCodes()
            correctCountryCode = pickCorrectAnswer(from: currentQuizFlagCodes)
            selectedFlag = nil
            rotationAmount = 0
    }
    
    func checkAnswer(_ selectedCode: String, remainingTime: Int) {
        selectedFlag = selectedCode
        
        if selectedCode == correctCountryCode {
            score += 10
            correctAnswers += 1
            scoreTitle = "Correct!"
            scoreMessage = ""
            rotationAmount += 360
            removeCorrectAnswer(correctCountryCode)
            
            if score > highScore {
                highScore = score
                UserDefaults.standard.set(highScore, forKey: "HighScore")
            }
        } else {
            score -= 10
            wrongAnswers += 1
            scoreTitle = "Wrong!"
            scoreMessage = "That's the flag of \(generateCountryName(for: selectedCode))"
        }
        
        if remainingCountryCodes.count < 4 || remainingTime < 1 {
            scoreTitle = "Game Over!"
            scoreMessage = "Final score: \(score)\nHigh score: \(highScore)"
        }
        
        showingScore = true
    }
    
    func generateCountryFlag(for countryCode: String) -> String {
        String(String.UnicodeScalarView(countryCode.unicodeScalars.compactMap {
            UnicodeScalar(127397 + $0.value)
        }))
    }
    
    func generateCountryName(for countryCode: String) -> String {
        Locale.current.localizedString(forRegionCode: countryCode) ?? ""
    }
    
    // MARK: - Private Methods
    private func populateQuizFlagCodes() -> [String] {
        var codes: [String] = []
        var tempArray = remainingCountryCodes.shuffled()
        
        for _ in 0...2 {
            if let code = tempArray.popLast() {
                codes.append(code)
            }
        }
        
        return codes
    }
    
    private func pickCorrectAnswer(from array: [String]) -> String {
        array.randomElement() ?? ""
    }
    
    private func removeCorrectAnswer(_ correctCode: String) {
        if let index = remainingCountryCodes.firstIndex(where: { $0 == correctCode }) {
            remainingCountryCodes.remove(at: index)
        }
    }
}

