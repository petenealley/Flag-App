//
//  MusicPlayerObject.swift
//  Flag App
//
//  Created by Pete Nealley on 2/16/25.
//

import SwiftUI
import AVKit

@Observable
class MusicPlayer {
    
    var audioPlayer: AVAudioPlayer?
//    let soundPath: String = ""
    let soundChoice: [String] = ["song1", "song2", "song3"]
    var isPlaying = false
    
    init(audioPlayer: AVAudioPlayer? = nil) {
        self.audioPlayer = audioPlayer
    }
    
//    func chooseSong() {
//        let songToPlay = soundChoice.randomElement() ?? "song1"
//    }
    
    func setupAudio() {
        let songToPlay = soundChoice.randomElement() ?? "song1"
        guard let url = Bundle.main.url(forResource: songToPlay, withExtension: "mp3") else {
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
        } catch {
            print("Error loading audio file: \(error)")
        }
    }
    
    func playSong() {
        audioPlayer?.play()
        isPlaying = true
    }
    
    func pauseSong() {
        audioPlayer?.pause()
        isPlaying = false
    }

    func stopSong() {
        audioPlayer?.play()
        isPlaying = false
    }
    
}

