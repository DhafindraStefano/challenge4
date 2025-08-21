//
//  StarDetailView.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 21/08/25.
//

import SwiftUI

// Custom shape with a wavy bottom edge
struct Wave: Shape {
    var baselineFraction: CGFloat
    var amplitudeFraction: CGFloat
    var inverted: Bool = false

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let baselineY = rect.height * baselineFraction
        let amplitude = rect.height * amplitudeFraction

        // Start at the wave baseline on the left
        path.move(to: CGPoint(x: rect.minX, y: baselineY))

        // Draw the sine wave across the width, flipping it if `inverted` is true
        for x in stride(from: 0, through: rect.width, by: 1) {
            let relativeX = x / rect.width
            let waveValue = sin(relativeX * 2 * .pi)
            let y = baselineY + (inverted ? -waveValue : waveValue) * amplitude
            path.addLine(to: CGPoint(x: x, y: y))
        }

        // Connect to the bottom corners
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()

        return path
    }
}

struct StarDetailView: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Light background
                Color("LightOrangeBackground")
                    .ignoresSafeArea()

                // Dark background clipped to the inverted wave
                Wave(baselineFraction: 0.33, amplitudeFraction: 0.05, inverted: true)
                    .fill(Color("DarkOrangeBackground"))
                    .ignoresSafeArea()
            }
            .overlay(
                VStack {
                    Text("Hello, World!")
                        .foregroundColor(.white)
                        .padding()
//                    Spacer()
                }
            )
        }
    }
}

#Preview {
    StarDetailView()
}
