//
//  MusicPlayerObject.swift
//  Flag App
//
//  Created by Pete Nealley on 2/16/25.
//

import SwiftUI
import AVKit

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("Error: Could not find and play the sound file!")
        }
    }
}
