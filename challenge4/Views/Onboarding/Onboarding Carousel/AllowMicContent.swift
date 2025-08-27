//
//  AllowMicContent.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 26/08/25.
//

import SwiftUI

//struct AllowMicContent: View {
//    var body: some View {
//        VStack(spacing: 20) {
//            Image("RabbitAudio")
//                .font(.system(size: 120))
//                .foregroundColor(.white.opacity(0.8))
//                .accessibilityLabel("Cartoon rabbit")
//                .accessibilityAddTraits(.isImage)
//            VStack(spacing: 8) {
//                Text("Microphone access")
//                    .accessibilityAddTraits(.isHeader)
//                    .font(.title.bold())
//                    .foregroundColor(.white)
//                    .fontDesign(.rounded)
//                
//                Text("Your data store locally and will not be shared")
//                    .font(.title3.weight(.light))
//                    .foregroundColor(.white.opacity(0.5))
//                    .fontDesign(.rounded)
//                    .multilineTextAlignment(.center)
//                    .frame(width: 280)
//                    .accessibilityLabel("Your data is stored locally and will not be shared")
//            }
//        }.padding(.bottom, 125)
//    }
//}

struct AllowMicContent: View {
    var body: some View {
        VStack(spacing: 20) {
            Image("RabbitAudio")
                .font(.system(size: 120))
                .foregroundColor(.white.opacity(0.8))
                .accessibilityLabel("Cartoon rabbit with headphones")
                .accessibilityAddTraits(.isImage)
            
            VStack(spacing: 8) {
                Text("Microphone access")
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .fontDesign(.rounded)
                    .accessibilityAddTraits(.isHeader)
                
                Text("Your data is stored locally and will not be shared")
                    .font(.title3.weight(.light))
                    .foregroundColor(.white.opacity(0.5))
                    .fontDesign(.rounded)
                    .multilineTextAlignment(.center)
                    .frame(width: 280)
            }
        }
        .padding(.bottom, 125)
        .accessibilityElement(children: .combine)
    }
}
#Preview {
    AllowMicContent()
        .background(Color.black)
}
