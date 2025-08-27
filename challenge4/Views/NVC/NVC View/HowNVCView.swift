//
//  NVCView.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 19/08/25.
//

import SwiftUI
import Lottie

struct HowNVCView: View {
    // MARK: - Parent
    @Binding var observationParent: RabitFaceObject?
    @Binding var feelingParent: FeelingObject?
    @Binding var needsParent: NeedObject?
    
    // MARK: - Child
    @Binding var observationChild: RabitFaceObject?
    @Binding var feelingChild: FeelingObject?
    @Binding var needsChild: NeedObject?
    
    // MARK: - Game
    @Binding var answerGame: FeelingObject?
    
    @Binding var child: Bool
    
    @State private var isNextActive: Bool = false
    @State private var ellipseScale: CGFloat = 10.0
    @State private var showTurnCard: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    var audioName : String = "How_do_you_feel_today"

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.background.ignoresSafeArea()
                
                VStack(spacing: geo.size.height * 0.01) {
                    Text("How do you feel")
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)

                    HStack(spacing: geo.size.width * 0.01) {
                        Text("today?")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                        Button {
                            AudioPlayer.shared.playAudio(named: audioName)
                        } label: {
                            Image(systemName: "speaker.wave.3.fill")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                        .accessibilityLabel("Play audio")
                        .accessibilityHint("Plays a question asking how you feel today")
                    }
                }
                .accessibilityElement(children: .combine)
                .accessibilityLabel("How do you feel today?")
                .offset(y: -geo.size.height * 0.18)
                .zIndex(2)
                TurnCard(isParent: !child)
                    .offset(
                        x: child ? geo.size.width * 0.22 : -geo.size.width * 0.22,
                        y: child ? -geo.size.height * 0.1 : -geo.size.height * 0.1
                    )
                    .opacity(showTurnCard ? 1.0 : 0.0)
                    .animation(.easeInOut(duration: 1.0), value: showTurnCard)
                    .zIndex(3)
                    .accessibilityLabel(child ? "It’s your child’s turn" : "It’s your turn")
                    .accessibilityAddTraits(.isStaticText)

                RabbitsTalkingView()
                    .accessibilityLabel("Two rabbits are talking together")
                    .accessibilityAddTraits(.isImage)
                    .zIndex(0)

                EmotionBar(
                    observationParent: $observationParent,
                    observationChild: $observationChild,
                    child: $child,
                    onNext: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            if !child && observationParent != nil {
                                isNextActive = true
                            } else if child && observationChild != nil {
                                isNextActive = true
                            }
                        }
                    }
                )
                .accessibilityLabel("Select how you are feeling")
                .accessibilityHint("Choose a feeling to continue")
                .zIndex(3)
                .offset(y: geo.size.height * 0.4)
                
                VStack {
                    HStack {
                        Button(action: { dismiss() }) {
                            BackButton()
                        }
                        .padding(.leading, 16)
                        .padding(.top, 46)
                        .accessibilityLabel("Back")
                        .accessibilityHint("Goes back to the previous screen")
                        Spacer()
                    }
                    Spacer()
                }
                
                Rectangle()
                    .fill(Color.black.opacity(0.8))
                    .ignoresSafeArea()
                    .mask {
                        Rectangle().overlay {
                            Ellipse()
                                .frame(
                                    width: (child ? geo.size.width * 0.5 : geo.size.width * 0.55) * ellipseScale,
                                    height: (child ? geo.size.height * 0.3 : geo.size.height * 0.35) * ellipseScale
                                )
                                .offset(
                                    x: child ? geo.size.width * 0.2 : -geo.size.width * 0.22,
                                    y: geo.size.height * 0.05
                                )
                                .blendMode(.destinationOut)
                            
                        }
                    }
                    .allowsHitTesting(false)

                if ellipseScale != 10.0 {
                    Rectangle()
                        .fill(Color.clear)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showTurnCard = false
                            withAnimation(.easeInOut(duration: 2.0)) {
                                ellipseScale = 10.0
                            }
                        }
                }
                
            }
            .ignoresSafeArea()
            .onAppear {
                withAnimation(.easeInOut(duration: 2.0)) {
                    ellipseScale = 1.0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    showTurnCard = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                    showTurnCard = false
                    withAnimation(.easeInOut(duration: 2.0)) {
                        ellipseScale = 10.0
                    }
                }
            }
            .navigationDestination(isPresented: $isNextActive) {
                WhyNVCView(
                    observationParent: $observationParent,
                    feelingParent: $feelingParent,
                    needsParent: $needsParent,
                    observationChild: $observationChild,
                    feelingChild: $feelingChild,
                    needsChild: $needsChild,
                    answerGame: $answerGame,
                    child: $child
                )
                .transaction { $0.disablesAnimations = true }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    @Previewable @State var observationParent: RabitFaceObject? = nil
    @Previewable @State var feelingParent: FeelingObject? = nil
    @Previewable @State var needsParent: NeedObject? = nil
    
    @Previewable @State var observationChild: RabitFaceObject? = nil
    @Previewable @State var feelingChild: FeelingObject? = nil
    @Previewable @State var needsChild: NeedObject? = nil
    
    @Previewable @State var answerGame: FeelingObject? = nil
    
    @Previewable @State var child: Bool = false
    
    HowNVCView(
        observationParent: $observationParent,
        feelingParent: $feelingParent,
        needsParent: $needsParent,
        observationChild: $observationChild,
        feelingChild: $feelingChild,
        needsChild: $needsChild,
        answerGame: $answerGame,
        child: $child
    )
}
