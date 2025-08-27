//
//  ShareFeelingContent.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 26/08/25.
//

import SwiftUI

struct ShareFeelingContent: View {
    var body: some View {
        VStack(spacing: 20) {
            Image("OnboardingFaces")
                .resizable()
                .scaledToFit()
                .frame(height: 180)
                .accessibilityLabel("Cartoon faces representing emotions")
                .accessibilityAddTraits(.isImage)
            
            VStack(spacing: 8) {
                Text("Share your feelings")
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .fontDesign(.rounded)
                    .accessibilityAddTraits(.isHeader)
                
                Text("Reflect on your day with your child using the Nonviolent Communication framework")
                    .font(.title3.weight(.light))
                    .foregroundColor(.white.opacity(0.5))
                    .fontDesign(.rounded)
                    .multilineTextAlignment(.center)
                    .frame(width: 280)
            }
        }
        .padding(.bottom, 100)
        .accessibilityElement(children: .combine) // ✅ read as one
    }
}

#Preview {
    ShareFeelingContent()
        .background(Color.black)
}
