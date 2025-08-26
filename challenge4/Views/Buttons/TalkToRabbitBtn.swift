//
//  StartButton.swift
//  challenge4
//
//  Created by Ardelia on 25/08/25.
//
//
//  BackButton.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 21/08/25.
//

import SwiftUI

/// A button style that adds a “bouncy” animation when the button is pressed.
struct TalkToRabbitButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        // Scale down when pressed and animate with a spring effect
            .scaleEffect(configuration.isPressed ? 0.85 : 1.0)
            .animation(
                .spring(response: 0.3, dampingFraction: 0.5),
                value: configuration.isPressed
            )
    }
}

struct TalkToRabbitBtn: View {
    @Binding var showHowNVCView : Bool
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
            Button(action: {
                showHowNVCView = true
            }) {
                HStack {
                    Image(systemName: "bubble.fill")
                    Text("Talk to Ms.Rabbit")
                }.font(.title2)
                    .fontDesign(.rounded)
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                    .padding(20)
                    .background(
                        // Only the shape gets filled & shadowed
                        RoundedRectangle(cornerRadius: 57, style: .continuous)
                            .fill(Color(.startTalkBtn))
                            .shadow(color: .startTalkBtnDropShadow.opacity(1), radius: 0, x: 0, y: 8)
                    )
                    .frame(maxWidth: 268, maxHeight: 69, alignment: .centerFirstTextBaseline)
            }
    }
}

#Preview {
    TalkToRabbitBtn(showHowNVCView: .constant(true) )
}

