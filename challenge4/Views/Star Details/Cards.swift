//
//  Cards.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 21/08/25.
//


import SwiftUI

struct Cards: View {
    enum CardState {
        case feeling, why, need, games
    }
    private var accessibilityTitle: String {
        switch state {
        case .feeling:
            return "Feeling card: \(rabitFace ?? "No feeling")"
        case .why:
            return "Reason card"
        case .need:
            if let needs = needs?.needs, !needs.isEmpty {
                return "Needs card: \(needs.map { $0.text }.joined(separator: ", "))"
            }
            return "Needs card: no needs logged"
        case .games:
            return "Game story card"
        }
    }

    private var accessibilityHint: String {
        switch state {
        case .feeling:
            return "Shows the current feeling"
        case .why:
            return "Play audio to hear the reason for the feeling"
        case .need:
            return "Shows needs"
        case .games:
            return "Play audio to hear the game story"
        }
    }

    var state: CardState
    
    var titleText: String
    var rabitFace: String? = nil
    var imageName: String? = nil
    var audioPathFeeling: String? = nil
    var audioPathGame: String? = nil
    var needs: NeedObject? = nil
    
    @StateObject private var audioController = AudioRecorderController()
    
    var body: some View {
        VStack(spacing: 0) {
            Text(titleText)
                .font(.headline)
                .foregroundColor(.white)
                .padding()

            Rectangle()
                .fill(Color.gray.opacity(0.1))
                .frame(height: 1)

            content
                .padding(2)
        }
        .background(Color("EmotionBarColor"))
        .cornerRadius(20)
        .padding(.horizontal, 5)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(accessibilityTitle)
        .accessibilityHint(accessibilityHint)
    }

    @ViewBuilder
    private var content: some View {
        switch state {
        case .feeling:
            if let imageName {
                Image(imageName)
                    .resizable()
                    .frame(width: 90, height: 90)
            }
            Text(rabitFace ?? "No feeling")
                .foregroundColor(.white)
                .padding(.bottom, 12) 

        case .why:
            if let audioPathFeeling {
                // CHANGE THE BUTTON
                ButtonStarDetail(
                    onPlay: {
                        audioController.playRecording(fileName: audioPathFeeling)
                    },
                    onPause: {
                        audioController.stopPlayback()
                    }
                )
                .padding(15)
            } else {
                Text("No reason recorded")
                    .foregroundColor(.gray)
                    .accessibilityLabel("No reason recorded")
            }
            
        case .need:
            if let needsObj = needs, !needsObj.needs.isEmpty {
                HStack {
                    ForEach(needsObj.needs, id: \.id) { need in
                        Text(need.text)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color("EmotionBarColorDropShadow"))
                            .clipShape(Capsule())
                    }
                }
                .accessibilityElement(children: .combine)
                .accessibilityLabel(needsObj.needs.map { $0.text }.joined(separator: ", "))
                .accessibilityHint("These are the needs")
                .padding(.bottom, 12)
            } else {
                Text("No needs logged")
                    .foregroundColor(.gray)
            }
        case .games:
            if let audioPathGame {
                ButtonStarDetail(
                    onPlay: {
                        audioController.playRecording(fileName: audioPathGame)
                    },
                    onPause: {
                        audioController.stopPlayback()
                    }
                )
                .padding(15)
            } else {
                Text("No game story recorded")
                    .foregroundColor(.gray)
                    .accessibilityLabel("No reason recorded")
            }

        }
    }
}

#Preview {
    VStack(spacing: 20) {
        // Feeling Card
        Cards(
            state: .feeling,
            titleText: "How I'm Feeling Today",
            rabitFace: "Happy 😊",
            imageName: "HappyFace"
        )
        
        // Why Card
        Cards(
            state: .why,
            titleText: "Why I Feel That Way",
            audioPathFeeling: "Audio_123.m4a"
        )
        
        // Need Card
        Cards(
            state: .need,
            titleText: "What I Need",
            needs: NeedObject(needs: ["Rest", "Play", "Connection"])
        )
        
        // Games Card
        Cards(
            state: .games,
            titleText: "Can you tell me a story?",
            audioPathGame: "GameStory_001.m4a"
        )
    }
    .padding()
    .background(Color.black)
}
