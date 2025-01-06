//
//  QuizModel.swift
//  Flag App
//
//  Created by Pete Nealley on 1/5/25.
//

import Foundation

class QuizData {
    
    var remainingCountryCodes: [String] = Locale.Region.isoRegions.filter {$0.subRegions.isEmpty}.map {$0.identifier}
    
    init() {
//        var remainingCountryCodes = Locale.Region.isoRegions.filter {$0.subRegions.isEmpty}.map {$0.identifier}
    }
    
    func populateQuizFlagCodesArray() -> [String] {
        var currentQuizFlagCodes: [String] = []
        var temporaryArray: [String] = remainingCountryCodes.shuffled()
        currentQuizFlagCodes.append(temporaryArray.popLast()!)
        temporaryArray = remainingCountryCodes.shuffled()
        currentQuizFlagCodes.append(temporaryArray.popLast()!)
        temporaryArray = remainingCountryCodes.shuffled()
        currentQuizFlagCodes.append(temporaryArray.popLast()!)
        temporaryArray = []
        return currentQuizFlagCodes
    }
    
    func removeCorrectAnswer(anArray: [String], correctCountryCode: String) -> [String] {
        var tempArray: [String] = anArray
        let indexOfCodeToRemove = anArray.firstIndex(where: { $0 == correctCountryCode })
        tempArray.remove(at: indexOfCodeToRemove!)
        return tempArray
    }
    
    func gamePlay() {
        
    }
}
