//
//  ContentView.swift
//  Flag App
//
//  Created by Pete Nealley on 1/3/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            //Background Image
            Image(.parchmenthoriz)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack {
                //Main Title
                Text("Ha Yool's Flag Quiz")
                    .font(.system(size: 72))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.top, 30)
                
                Spacer()
                
                //Flags
                HStack {
                    //leftFlag
                    Button {
                        print("Left Flag Button Pressed")
                    } label: {
                        Text("🇺🇸")
                            .font(.system(size: 300))
                            .padding(.vertical, -55)
                            .padding(.horizontal, 5)
                            .background(.black.opacity(0.5))
                            .cornerRadius(40)
                    }
                    //FcenterFlag
                    Button {
                        print("Center Flag Button Pressed")
                    } label: {
                        Text("🇰🇷")
                            .font(.system(size: 300))
                            .padding(.vertical, -55)
                            .padding(.horizontal, 5)
                            .background(.black.opacity(0.5))
                            .cornerRadius(40)
                    }
                    
                    //rightFlag
                    Button {
                        print("Right Flag Button Pressed")
                    } label: {
                        Text("🏴󠁧󠁢󠁳󠁣󠁴󠁿")
                            .font(.system(size: 300))
                            .padding(.vertical, -55)
                            .padding(.horizontal, 5)
                            .background(.black.opacity(0.5))
                            .cornerRadius(40)
                    }
                }
                
                //Challenge
                HStack {
                    //Quiz Question
                    Text("Which one is the flag of")
                    
                    //Quiz Country
                    Text("South Korea")
                        .foregroundStyle(.red)
                    
                    //Question Mark
                    Text("?")
                }
                .font(.system(size: 48))
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                //Buttons to Start Pause & Stop
                HStack {
                    //Start Button
                    Button("Start") {
                        
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    .font(.largeTitle)
                    .padding()
                    
                    //Pause Button
                    Button("Pause") {
                        
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.yellow)
                    .font(.largeTitle)
                    .padding()
                    
                    //End Button
                    Button("End") {
                        
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                    .font(.largeTitle)
                    .padding()
                }
                .foregroundColor(.white)
                .fontWeight(.bold)
                
                //                Spacer()
                
                //Score Info
                HStack {
                    
                    //Timer
                    
                    VStack {
                        //Current Score
                        Text("Current Score:")
                            .font(.title)
                            .padding(.top)
                            .padding(.bottom)
                            .fontWeight(.bold)
                        
                        
                        //Number of Correct Guesses
                        Text("Correct Guesses:")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        
                        //Number of Incorrect Guesses
                        Text("Incorrect Guesses:")
                            .font(.title)
                            .padding(.bottom)
                            .fontWeight(.bold)
                        
                        
                    }
                    .frame(width: 400)
                    //                .frame(alignment: .leading)
                    .background(.indigo.opacity(0.9))
                    .cornerRadius(20)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    
                    //Music On/Off Switch
                    HStack {
                        //Music Icon On
                        
                        //Switch
                        
                        //Music Icon Off
                    }
                    
                }
                
                
                Spacer()
                
            }
            .foregroundColor(.black)
        }
    }
}

#Preview(traits: .landscapeLeft) {
    ContentView()
}
