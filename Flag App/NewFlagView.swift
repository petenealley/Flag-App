//
//  NewFlagView.swift
//  Flag App
//
//  Created by Paul Jordan on 2/26/25.
//

import SwiftUI

struct NewFlagView: View {
    @State private var viewModel = FlagViewModel(
        countries: Locale.Region.isoRegions.filter { $0.subRegions.isEmpty }.map { Country(code: $0.identifier) }
    )
    @State var isMusicOn = true
    @Environment(TimerObject.self) var timerObject
    @State private var width: CGFloat = 0
    @State var musicPlayer = MusicPlayer()
    
    var body: some View {
        ZStack {
            Image(.parchmenthoriz)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack {
                Text("Ha Yool's Flag Quiz")
                    .font(.system(size: 72))
                    .fontWeight(.bold)
                    .tracking(5)
                    .padding(.top, 30)
                
                Spacer()
                
                FlagQuizView(viewModel: viewModel)
                
                HStack {
                    TimerView(
                        width: $width,
                        gamePaused: $viewModel.gamePaused,
                        isMusicOn: $isMusicOn,
                        musicPlayer: musicPlayer,
                        onReset: {
                            viewModel.startNewGame()
                            timerObject.resetTimer()
                            musicPlayer.setupAudio()
                        },
                        controls: true  // Explicitly pass controls as true
                    )
                    ScoreInfoView(viewModel: viewModel)
                    SettingsView(viewModel: viewModel, isMusicOn: $isMusicOn, musicPlayer: musicPlayer)
                }
            }
            .foregroundColor(.black)
            .onAppear {
                musicPlayer.setupAudio()
            }
        }
        .alert(viewModel.scoreTitle, isPresented: $viewModel.showingScore) {
            if viewModel.scoreTitle == "Game Over!" {
                Button("Game Over", action: {
                    musicPlayer.stopSong()
                    viewModel.startNewGame()
                    timerObject.resetTimer()
                    musicPlayer.setupAudio()
                })
            } else {
                Button("Continue", action: viewModel.startNewRound)
            }
        } message: {
            Text(viewModel.scoreMessage)
        }
    }
}

#Preview(traits: .landscapeRight) {
    NewFlagView()
        .environment(TimerObject(timerColor: .indigo, length: 180))
}
