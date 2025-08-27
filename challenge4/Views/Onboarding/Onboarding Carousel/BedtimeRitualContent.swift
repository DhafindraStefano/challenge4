//
//  BedtimeRitualContent.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 26/08/25.
//

import SwiftUI

struct BedtimeRitualContent: View {
    var body: some View {
        VStack(spacing: 20) {
            Image("Calendar")
                .font(.system(size: 120))
                .foregroundColor(.white.opacity(0.8))
                .accessibilityLabel("Calendar icon representing bedtime routine")
                .accessibilityAddTraits(.isImage)
            
            VStack(spacing: 8) {
                Text("Create bedtime rituals")
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .fontDesign(.rounded)
                    .accessibilityAddTraits(.isHeader)
                
                Text("End each day with connection and understanding")
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
    BedtimeRitualContent()
        .background(Color.black)
}
