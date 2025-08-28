//
//  OnboardingCards.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 26/08/25.
//

import SwiftUI

enum OnboardingState: String, CaseIterable {
    case sharefeeling = "sharefeeling"
    case growcloser = "growcloser"
    case bedtimeritual = "bedtimeritual"
    case allowmic = "allowmic"
}

struct OnboardingCards: View {
    @State private var currentState: OnboardingState = .sharefeeling
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    @State private var myOffsetAmount: CGFloat = -150
    var onFinish: () -> Void
    
    var onFinish: () -> Void
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .offset(x: myOffsetAmount, y: -30)
                .onAppear {
                    if !UIAccessibility.isReduceMotionEnabled {
                        withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
                            myOffsetAmount = 500
                        }
                    }
                }
            
            RoundedRectangle(cornerRadius: 36, style: .continuous)
                .fill(Color.cardBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 36, style: .continuous)
                        .strokeBorder(Color.cardBorder, lineWidth: 8)
                )
                .shadow(color: .black.opacity(0.35), radius: 18, y: 8)
                .frame(width: 364, height: 542)
                .zIndex(2)
                .animation(.none, value: myOffsetAmount)
            
            VStack(spacing: 0) {
                ZStack {
                    switch currentState {
                    case .sharefeeling:
                        ShareFeelingContent()
                    case .growcloser:
                        GrowCloserContent()
                    case .bedtimeritual:
                        BedtimeRitualContent()
                    case .allowmic:
                        AllowMicContent()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .accessibilityElement(children: .combine)
                
                Spacer()
            }
            .animation(.none, value: myOffsetAmount)
            .padding(.vertical, 30)
            .zIndex(2)
            
            VStack {
                Spacer()
                if currentState == .allowmic {
                    PermissionButtons(onAllow: {
                        print("Microphone permission granted")
                        hasSeenOnboarding = true
                        onFinish()
                    })
                    .accessibilityElement(children: .contain)
                } else {
                    NextButton(action: {
                        handleNextButtonTap()
                    })
                    .accessibilityLabel("Next")
                    .accessibilityHint("Moves to the next onboarding step")
                }
            }
            .animation(.none, value: myOffsetAmount)
            .padding(.bottom, 165)
            .zIndex(2)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func handleNextButtonTap() {
        switch currentState {
        case .sharefeeling:
            currentState = .growcloser
            UIAccessibility.post(notification: .announcement, argument: "Grow closer together screen")
        case .growcloser:
            currentState = .bedtimeritual
            UIAccessibility.post(notification: .announcement, argument: "Create bedtime rituals screen")
        case .bedtimeritual:
            currentState = .allowmic
            UIAccessibility.post(notification: .announcement, argument: "Microphone access screen")
        case .allowmic:
            break
        }
    }
}
//enum OnboardingState: String, CaseIterable {
//    case sharefeeling = "sharefeeling"
//    case growcloser = "growcloser"
//    case bedtimeritual = "bedtimeritual"
//    case allowmic = "allowmic"
//}
//
//struct OnboardingCards: View {
//    @State private var currentState: OnboardingState = .sharefeeling
//    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
//    @State private var myOffsetAmount: CGFloat = -150
//    var onFinish: () -> Void
//    var body: some View {
//        ZStack {
//            Color.background.ignoresSafeArea()
//            Image("Background")
//                .resizable()
//                .scaledToFill()
//                .ignoresSafeArea()
//                .offset(x: myOffsetAmount, y: -30)
//                .onAppear {
//                    withAnimation(
//                        .linear(duration: 4)
//                        .repeatForever(autoreverses: false)
//                    ) {
//                        myOffsetAmount = 500
//                    }
//                }
//
//            RoundedRectangle(cornerRadius: 36, style: .continuous)
//                .fill(Color.cardBackground)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 36, style: .continuous)
//                        .strokeBorder(Color.cardBorder, lineWidth: 8)
//                )
//                .shadow(color: .black.opacity(0.35), radius: 18, y: 8)
//                .frame(width: 364, height: 542)
//                .zIndex(2)
//                .animation(.none, value: myOffsetAmount)
//            
//            VStack(spacing: 0) {
//                // Main content area
//                ZStack {
//                    switch currentState {
//                    case .sharefeeling:
//                        ShareFeelingContent()
//                    case .growcloser:
//                        GrowCloserContent()
//                    case .bedtimeritual:
//                        BedtimeRitualContent()
//                    case .allowmic:
//                        AllowMicContent()
//                    }
//                }
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .accessibilityElement(children: .combine)
//                Spacer()
//            }
//            .animation(.none, value: myOffsetAmount)
//            .zIndex(2)
////            .padding(.top, 20)
//            .padding(.vertical,30)
//            
//            // Bottom button area
//            VStack {
//                Spacer()
//                if currentState == .allowmic {
//                    PermissionButtons(onAllow: {
//                        print("Microphone permission granted")
//                        hasSeenOnboarding = true   // ✅ done here
//                    })
//                } else {
//                    NextButton(action: {
//                        handleNextButtonTap()
//                    })
//                    .accessibilityLabel("Next")
//                    .accessibilityHint("Moves to the next onboarding step")
//                }
//            }
//            .animation(.none, value: myOffsetAmount)
//            .zIndex(2)
//            .padding(.bottom, 165)
//        }
//        .navigationBarBackButtonHidden(true)
////        .overlay(
////            Image("Background")
////                .resizable()
////                .scaledToFill()
////                .ignoresSafeArea()
////                .offset(x: offsetAmount, y: -30)
////                .onAppear {
////                    withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
////                        offsetAmount = 500
////                    }
////                },
////            alignment: .center
////        )
//    }
//
//    
//    private func handleNextButtonTap() {
//        switch currentState {
//        case .sharefeeling:
//            currentState = .growcloser
//            UIAccessibility.post(notification: .announcement, argument: "Grow closer together screen")
//        case .growcloser:
//            currentState = .bedtimeritual
//            UIAccessibility.post(notification: .announcement, argument: "Create bedtime rituals screen")
//        case .bedtimeritual:
//            currentState = .allowmic
//            UIAccessibility.post(notification: .announcement, argument: "Microphone access screen")
//        case .allowmic:
//            break
//        }
//    }
//}

#Preview {
    OnboardingCards(onFinish: {
        print("Onboarding finished")
    })
}

