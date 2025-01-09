//
//  Country.swift
//  Flag App
//
//  Created by Pete Nealley on 1/5/25.
//

import Foundation

var remainingCountryCodes: [String] = Locale.Region.isoRegions.filter {$0.subRegions.isEmpty}.map {$0.identifier}
var currentQuizCountryCodes = populateQuizFlagCodesArray(allRemainingCountryCodes: remainingCountryCodes)
var correctAnswerCountryCode = pickCorrectAnswer(anArray: currentQuizCountryCodes)



struct Country {

}

struct Game {

}
