//
//  GrowCloserContent.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 26/08/25.
//

import SwiftUI

struct GrowCloserContent: View {
    var body: some View {
        VStack(spacing: 20) {
            Image("OnboardingBunnies")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .accessibilityLabel("Two bunnies sitting together, representing bonding")
                .accessibilityAddTraits(.isImage)
            
            VStack(spacing: 8) {
                Text("Grow closer together")
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .fontDesign(.rounded)
                    .accessibilityAddTraits(.isHeader)
                
                Text("Build stronger bonds through meaningful conversations")
                    .font(.title3.weight(.light))
                    .foregroundColor(.white.opacity(0.5))
                    .fontDesign(.rounded)
                    .multilineTextAlignment(.center)
                    .frame(width: 280)
            }
        }
        .padding(.bottom, 100)
        .accessibilityElement(children: .combine)
    }
}
#Preview {
    GrowCloserContent()
        .background(.black)
}
