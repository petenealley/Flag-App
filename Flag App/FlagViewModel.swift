//
//  FlagViewModel.swift
//  Flag App
//
//  Created by Paul Jordan on 2/26/25.
//

import Foundation
import SwiftUI

@Observable
class FlagViewModel {
    private(set) var currentQuizCountries: [Country] = []
    private(set) var correctCountry: Country?
    private(set) var remainingCountries: [Country] = []
    private(set) var score = 0
    private(set) var correctAnswers = 0
    private(set) var wrongAnswers = 0
    var highScore = UserDefaults.standard.integer(forKey: "HighScore")
    var showingScore = false
    var scoreTitle = ""
    var scoreMessage = ""
    var rotationAmount = 0.0
    var selectedCountry: Country?
    var gamePaused = true
    
    private let allCountries: [Country]
    
    init(countries: [Country]) {
        self.allCountries = countries
        self.remainingCountries = countries
        startNewGame()
    }
    
    func resetHighScore() {
        highScore = 0
        UserDefaults.standard.set(highScore, forKey: "HighScore")
    }
    
    func startNewGame() {
        gamePaused = true
        score = 0
        correctAnswers = 0
        wrongAnswers = 0
        remainingCountries = allCountries
        if let sarkIndex = remainingCountries.firstIndex(where: { $0.code == "CQ" }) {
            remainingCountries.remove(at: sarkIndex)
        }
        startNewRound()
    }
    
    func startNewRound() {
        currentQuizCountries = populateQuizCountries()
        correctCountry = pickCorrectAnswer(from: currentQuizCountries)
        selectedCountry = nil
        rotationAmount = 0
    }
    
    func checkAnswer(_ selectedCountry: Country, remainingTime: Int) {
        self.selectedCountry = selectedCountry
        
        if selectedCountry == correctCountry {
            score += 10
            correctAnswers += 1
            scoreTitle = "Correct!"
            scoreMessage = ""
            rotationAmount += 360
            removeCorrectAnswer(correctCountry!)
            
            if score > highScore {
                highScore = score
                UserDefaults.standard.set(highScore, forKey: "HighScore")
            }
        } else {
            score -= 10
            wrongAnswers += 1
            scoreTitle = "Wrong!"
            scoreMessage = "That's the flag of \(selectedCountry.name)"
        }
        
        if remainingCountries.count < 4 || remainingTime < 1 {
            scoreTitle = "Game Over!"
            scoreMessage = "Final score: \(score)\nHigh score: \(highScore)"
        }
        
        showingScore = true
    }
    
    private func populateQuizCountries() -> [Country] {
        var countries: [Country] = []
        var tempArray = remainingCountries.shuffled()
        
        for _ in 0...2 {
            if let country = tempArray.popLast() {
                countries.append(country)
            }
        }
        
        return countries
    }
    
    private func pickCorrectAnswer(from array: [Country]) -> Country? {
        array.randomElement()
    }
    
    private func removeCorrectAnswer(_ correctCountry: Country) {
        if let index = remainingCountries.firstIndex(of: correctCountry) {
            remainingCountries.remove(at: index)
        }
    }
}
