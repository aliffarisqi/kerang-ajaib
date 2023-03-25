//
//  MuteButton.swift
//  kerang ajaib
//
//  Created by Kezia Gloria on 24/03/23.
//

import SwiftUI
import AVFoundation


struct MuteButton {
    static let shared = MuteButton()
    var audioPlayer: AVAudioPlayer!
    static var isMuted : Bool = false
    
    init(){
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            guard let sound = Bundle.main.path(forResource: "BGM", ofType: "mp3") else { return }
            self.audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            self.audioPlayer.numberOfLoops = -1
            self.audioPlayer.prepareToPlay()
            self.audioPlayer.play()
            audioPlayer.setVolume(1, fadeDuration: 0.5)
        } catch let error {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
    
    func mute() {
        MuteButton.isMuted = true
        audioPlayer.setVolume(0, fadeDuration: 0.5)
    }
    
    func unmute() {
        MuteButton.isMuted = false
        audioPlayer.setVolume(1, fadeDuration: 0.5)
    }
}

struct ButtonMuteView: View{
    @State private var isMuted = MuteButton.isMuted
    @State private var btn = MuteButton.shared
    
    var body: some View{
        Button(action: {
            self.isMuted.toggle()
            if self.isMuted {
                self.btn.mute()
            } else {
                self.btn.unmute()
            }
        }) {
            Image(systemName: self.isMuted ? "speaker.slash.fill" : "speaker.3.fill")
                .font(.system(size: 20))
                .foregroundColor(.blue)
        }
        .onAppear {
            isMuted = MuteButton.isMuted
        }
        .onDisappear {
            MuteButton.isMuted = isMuted
        }
    }
}
