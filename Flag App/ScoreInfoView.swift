//
//  ScoreInfoView.swift
//  Flag App
//
//  Created by Paul Jordan on 2/26/25.
//


import SwiftUI

struct ScoreInfoView: View {
    var viewModel: FlagViewModel
    
    var body: some View {
        VStack {
            Text("Current Score: \(viewModel.score)")
                .font(.largeTitle)
                .padding(.top)
                .padding(.bottom)
                .fontWeight(.bold)
            Text("Correct Guesses: \(viewModel.correctAnswers)")
                .font(.title)
                .fontWeight(.bold)
            Text("Incorrect Guesses: \(viewModel.wrongAnswers)")
                .font(.title)
                .padding(.bottom)
                .fontWeight(.bold)
        }
        .frame(width: 400, height: 200)
        .background(.indigo.opacity(0.9))
        .cornerRadius(20)
        .foregroundColor(.white)
        .padding(.leading, 50)
    }
}
