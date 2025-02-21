//
//  MusicPlayerObject.swift
//  Flag App
//
//  Created by Pauk Jordan on 2/16/25.
//

import SwiftUI
import AVKit

@Observable
class MusicPlayer {
    
    var audioPlayer: AVAudioPlayer?
    let soundChoice: [String] = ["song1", "song3", "song4", "song5"]
    var isPlaying = false
    
    init(audioPlayer: AVAudioPlayer? = nil) {
        self.audioPlayer = audioPlayer
    }
    
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
        
        do {
            try AVAudioSession.sharedInstance().setCategory(
                .playback,
                mode: .default,
                options: []
                )
        } catch {
            print("Error setting audio session category: \(error)")
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
        audioPlayer?.setVolume(0.0, fadeDuration: 5.0)
        audioPlayer?.pause()
        isPlaying = false
    }
    
}

