import SwiftUI

struct FlagView: View {
    @StateObject private var viewModel = FlagViewModel(
        countryCodes: Array(Locale.Region.isoRegions.filter { $0.subRegions.isEmpty }.map { $0.identifier })
    )
    
    var body: some View {
        ZStack {
            //Background Image
            Image(.parchmenthoriz)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack {
                Text("Guess the Flag!")
                    .font(.largeTitle.bold())
                    .padding()
                
                Picker("Difficulty", selection: $viewModel.difficulty) {
                    ForEach(FlagViewModel.Difficulty.allCases, id: \.self) { difficulty in
                        Text(difficulty.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(viewModel.generateCountryName(for: viewModel.correctCountryCode))
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(viewModel.currentQuizFlagCodes, id: \.self) { countryCode in
                        Button {
                            withAnimation {
                                viewModel.checkAnswer(countryCode)
                            }
                        } label: {
                            Text(viewModel.generateCountryFlag(for: countryCode))
                                .font(.system(size: 100))
                                .rotation3DEffect(
                                    .degrees(viewModel.selectedFlag == countryCode ? viewModel.rotationAmount : 0),
                                    axis: (x: 0, y: 1, z: 0)
                                )
                                .opacity(viewModel.selectedFlag == nil || viewModel.selectedFlag == countryCode ? 1 : 0.25)
                                .scaleEffect(viewModel.selectedFlag == nil || viewModel.selectedFlag == countryCode ? 1 : 0.8)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                HStack {
                    Text("Score: \(viewModel.score)")
                    Spacer()
                    Text("High Score: \(viewModel.highScore)")
                }
                .font(.title2.bold())
                .padding()
            }
            .padding()
            .alert(viewModel.scoreTitle, isPresented: $viewModel.showingScore) {
                if viewModel.scoreTitle == "Game Over!" {
                    Button("New Game", action: viewModel.startNewGame)
                } else {
                    Button("Continue", action: viewModel.nextQuestion)
                }
            } message: {
                Text(viewModel.scoreMessage)
            }
        }
    }
}

#Preview {
    FlagView()
}
