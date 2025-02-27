//
//  SettingsView.swift
//  Flag App
//
//  Created by Paul Jordan on 2/26/25.
//


import SwiftUI

struct SettingsView: View {
    var viewModel: FlagViewModel
    @Binding var isMusicOn: Bool
    var musicPlayer: MusicPlayer
    
    var body: some View {
        VStack {
            VStack {
                Text("High Score: \(viewModel.highScore)")
                    .font(.title)
                    .padding()
                    .fontWeight(.bold)
            }
            .frame(width: 310)
            .background(.green.opacity(1))
            .cornerRadius(20)
            .foregroundColor(.white)
            .padding(.leading, 50)
            
            HStack {
                Image(systemName: "gear")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.gray)
                    .fontWeight(.bold)
                    .padding(.top, -50)
                    .padding(.leading, 15)
                VStack {
                    Toggle("Music", systemImage: isMusicOn ? "speaker.circle" : "speaker.slash.circle", isOn: $isMusicOn)
                        .tint(.white.opacity(0.0))
                        .font(.system(size: 60))
                        .padding(.top, 5)
                        .toggleStyle(.button)
                        .contentTransition(.symbolEffect)
                        .labelStyle(.iconOnly)
                        .onChange(of: isMusicOn) {
                            if musicPlayer.isPlaying {
                                musicPlayer.pauseSong()
                            } else {
                                if !viewModel.gamePaused {
                                    musicPlayer.playSong()
                                }
                            }
                        }
                    Text("Music")
                        .font(.title2)
                        .padding(.bottom, 7)
                        .padding(.top, -10)
                }
                Spacer()
                VStack {
                    Button {
                        viewModel.resetHighScore()
                    } label: {
                        Image(systemName: "square.and.pencil.circle")
                            .resizable()
                            .frame(width: 65, height: 65)
                            .foregroundColor(.black)
                            .padding(.top, 16)
                            .padding(.bottom, 11)
                    }
                    .buttonStyle(ScaleButtonStyle())
                    
                    Text("Reset Hi Score")
                        .font(.title2)
                        .padding(.bottom, 10)
                        .padding(.top, -10)
                }
                .padding(.trailing, 20)
            }
            .frame(width: 310)
            .background(.white)
            .cornerRadius(20)
            .foregroundColor(.black)
            .padding(.leading, 50)
        }
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}
