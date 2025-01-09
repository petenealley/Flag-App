//
//  FlagAppModel.swift
//  Flag App
//
//  Created by Pete Nealley on 1/9/25.
//

import Foundation

let allCountryCodes = Locale.Region.isoRegions.filter {$0.subRegions.isEmpty}.map {$0.identifier}

var remainingCountryCodes: [String] = Locale.Region.isoRegions.filter {$0.subRegions.isEmpty}.map {$0.identifier}
var currentQuizCountryCodes = populateQuizFlagCodesArray(allRemainingCountryCodes: remainingCountryCodes)
var correctAnswerCountryCode = pickCorrectAnswer(anArray: currentQuizCountryCodes)

var totalRemainingCountries = remainingCountryCodes.count
var currentQuizFlagCodes: [String] = []
