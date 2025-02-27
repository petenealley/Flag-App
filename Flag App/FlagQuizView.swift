//
//  FlagQuizView.swift
//  Flag App
//
//  Created by Paul Jordan on 2/26/25.
//


import SwiftUI

struct FlagQuizView: View {
    var viewModel: FlagViewModel
    @Environment(TimerObject.self) var timerObject
    
    var body: some View {
        VStack {
            HStack {
                ForEach(viewModel.currentQuizCountries) { country in
                    Button {
                        withAnimation {
                            viewModel.checkAnswer(country, remainingTime: timerObject.remainingTime)
                        }
                        if timerObject.remainingTime == 0 {
                            viewModel.gamePaused = true
                        }
                    } label: {
                        Text(country.flag)
                            .font(.system(size: 300))
                            .padding(.vertical, -55)
                            .padding(.horizontal, 5)
                            .background(.black.opacity(0.5))
                            .cornerRadius(40)
                            .rotation3DEffect(
                                .degrees(viewModel.selectedCountry == country ? viewModel.rotationAmount : 0),
                                axis: (x: 0, y: 1, z: 0)
                            )
                    }
                }
            }
            .disabled(viewModel.gamePaused)
            
            HStack {
                Text("Which one is the flag of")
                Text(viewModel.correctCountry?.name ?? "")
                    .foregroundStyle(.red)
                Text("?")
            }
            .font(.system(size: 48))
            .fontWeight(.bold)
        }
    }
}
