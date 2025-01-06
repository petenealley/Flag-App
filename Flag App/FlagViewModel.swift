//
//  FlagViewModel.swift
//  Flag App
//
//  Created by Pete Nealley on 1/5/25.
//

import Foundation

var remainingCountryCodes: [String] = Locale.Region.isoRegions.filter {$0.subRegions.isEmpty}.map {$0.identifier}
var totalRemainingCountries = remainingCountryCodes.count
var currentQuizFlagCodes: [String] = []

func populateQuizFlagCodesArray() -> [String] {
    currentQuizFlagCodes = []
    var temporaryArray = remainingCountryCodes.shuffled()
    currentQuizFlagCodes.append(temporaryArray.popLast()!)
    temporaryArray = remainingCountryCodes.shuffled()
    currentQuizFlagCodes.append(temporaryArray.popLast()!)
    temporaryArray = remainingCountryCodes.shuffled()
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
    var correctCountryAnswerCode = anArray.randomElement()
    return correctCountryAnswerCode!
}

