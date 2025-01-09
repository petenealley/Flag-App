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

var correctAnswers = 0
var wrongAnswers = 0
var currentScore = 0

var leftFlagCountryCode = currentQuizCountryCodes[0]
var centerFlagCountryCode = currentQuizCountryCodes[1]
var rightFlagCountryCode = currentQuizCountryCodes[2]
var correctAnswer = generateCountryName(correctAnswerCountryCode)
