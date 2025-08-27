//
//  ButtonStarDetail.swift
//  challenge4
//
//  Created by Levana on 25/08/25.
//

import SwiftUI
//import AVFAudio

struct ButtonStarDetail: View {
    var onPlay: () -> Void
    var onPause: () -> Void
    
    @State private var duration: Double = 0.0   // store duration in seconds
    
    func fadeVolume(to target: Float, duration: TimeInterval = 2.0) {
        guard let player = BackgroundMusicPlayer.shared.player else { return }
        
        let steps = 20
        let stepTime = duration / Double(steps)
        let stepVolume = (target - player.volume) / Float(steps)
        
        for i in 0..<steps {
            DispatchQueue.main.asyncAfter(deadline: .now() + stepTime * Double(i)) {
                player.volume += stepVolume
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                Button(action: {
                    if let player = BackgroundMusicPlayer.shared.player {
                        player.volume = 0.0   // mute first
                    }
                    onPlay()
                    fadeVolume(to: 0.1, duration: 3.0)
                }) {
                    Image(systemName: "play.fill")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(15)
                        .background(Color.checkmark)
                        .clipShape(Circle())
                        .shadow(color: .checkmarkDropShadow.opacity(1), radius: 0, x: 0, y: 8)
                }
                .accessibilityLabel("Play")
                .accessibilityHint("Plays the audio and fades in volume")
                Button(action: {
                    onPause()
                    if let player = BackgroundMusicPlayer.shared.player {
                        player.volume = 0.1
                    }
                }) {
                    Image(systemName: "pause.fill")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(15)
                        .background(Color.pause)
                        .clipShape(Circle())
                        .shadow(color: .pauseDropShadow.opacity(1), radius: 0, x: 0, y: 8)
                }
                .accessibilityLabel("Pause")
                .accessibilityHint("Pauses the audio playback")
            }
            
//            // show duration below buttons
//            if duration >= 0 {
//                HStack(spacing: 4) {
//                    Image(systemName: "timer")
//                        .foregroundColor(.white)
//                    Text(formatTime(duration))
//                        .font(.subheadline)
//                        .foregroundColor(.white)
//                }
//                .padding(.horizontal, 8)
//                .padding(.vertical, 4)
//                .background(Color.black.opacity(0.8))
//                .cornerRadius(8)
//            }
                
        }
//        .onAppear {
//            if let url = Bundle.main.url(forResource: "effect", withExtension: "mp3") {
//                do {
//                    let player = try AVAudioPlayer(contentsOf: url)
//                    self.duration = player.duration
//                } catch {
//                    print("Error loading sound: \(error)")
//                }
//            }
//        }
    }

//    private func formatTime(_ time: Double) -> String {
//        let minutes = Int(time) / 60
//        let seconds = Int(time) % 60
//        return String(format: "%d:%02d", minutes, seconds)
//    }
}

#Preview {
    ButtonStarDetail(
        onPlay: { print("Play pressed") },
        onPause: { print("Pause pressed") }
    )
}
