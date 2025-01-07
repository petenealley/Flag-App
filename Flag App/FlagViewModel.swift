//
//  FlagViewModel.swift
//  Flag App
//
//  Created by Pete Nealley on 1/5/25.
//

import Foundation


var totalRemainingCountries = remainingCountryCodes.count
var currentQuizFlagCodes: [String] = []

func populateQuizFlagCodesArray(allRemainingCountryCodes: [String]) -> [String] {
    currentQuizFlagCodes = []
    var temporaryArray = allRemainingCountryCodes.shuffled()
    currentQuizFlagCodes.append(temporaryArray.popLast()!)
    temporaryArray = allRemainingCountryCodes.shuffled()
    currentQuizFlagCodes.append(temporaryArray.popLast()!)
    temporaryArray = allRemainingCountryCodes.shuffled()
    currentQuizFlagCodes.append(temporaryArray.popLast()!)
    temporaryArray = []
    return currentQuizFlagCodes
}

func generateCountryFlag(_ countryCode: String) -> String {
    String(String.UnicodeScalarView(countryCode.unicodeScalars.compactMap {
        UnicodeScalar(127397 + $0.value)
    }))
}

func generateCountryName(_ countryCode: String) -> String {
    let countryName = (Locale.current.localizedString(forRegionCode: countryCode) ?? "")
    return countryName
}

func pickCorrectAnswer(anArray: [String]) -> String {
    let correctCountryAnswerCode = anArray.randomElement()
    return correctCountryAnswerCode!
}

func removeCorrectAnswer(anArray: [String], correctCountryCode: String) -> [String] {
    var tempArray: [String] = anArray
    let indexOfCodeToRemove = anArray.firstIndex(where: { $0 == correctCountryCode })
    tempArray.remove(at: indexOfCodeToRemove!)
    return tempArray
}

