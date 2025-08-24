//
//  RisingStar2.swift
//  challenge4
//
//  Created by Ardelia on 25/08/25.
//
import SwiftUI

struct RisingMemoryStar1: View {
    var imageName = "StarHome"
    /// Where to start (fraction of screen). Tweak so it sits between your rabbits.
    var startY: CGFloat = 0.62
    /// Where to stop (near the top).
    var endY: CGFloat = 0.12
    var travelDuration: Double = 1.2
    var startScale: CGFloat = 0.4
    var endScale: CGFloat = 1.0
    var shinePulses: Int = 2

    @State private var pos: CGPoint = .zero
    @State private var scale: CGFloat = 0.4
    @State private var shining = false

    var body: some View {
        GeometryReader { geo in
            let cx = geo.size.width / 2
            let start = CGPoint(x: cx, y: geo.size.height * startY)
            let end   = CGPoint(x: cx, y: geo.size.height * endY)

            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 56, height: 56)
                .position(pos)
                .scaleEffect(scale)
                // subtle base glow
                .shadow(color: .white.opacity(0.25), radius: 8, x: 0, y: 0)
                // “shine” burst when it arrives
                .overlay(
                    Circle()
                        .strokeBorder(.white.opacity(shining ? 0.95 : 0), lineWidth: shining ? 8 : 0)
                        .blur(radius: shining ? 10 : 0)
                        .blendMode(.screen) // makes the highlight pop on dark bg
                )
                .onAppear {
                    // set at start
                    pos = start
                    scale = startScale

                    // travel upward while growing
                    withAnimation(.easeInOut(duration: travelDuration)) {
                        pos = end
                        scale = endScale
                    }

                    // start the shine once we arrive
                    DispatchQueue.main.asyncAfter(deadline: .now() + travelDuration) {
                        withAnimation(.easeInOut(duration: 0.6).repeatCount(shinePulses * 2, autoreverses: true)) {
                            shining = true
                        }
                        // optional: settle the shine back down
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6 * Double(shinePulses * 2)) {
                            shining = false
                        }
                    }
                }
        }
        .allowsHitTesting(false) // won’t block your buttons
    }
}

//struct RisingStar1: View {
//    var body: some View {
//        ZStack {
//            // … background …
//
//            // rabbits here
//
//            RisingMemoryStar1(imageName: "StarHome",
//                             startY: 0.62,  // tweak to match your rabbits’ vertical line
//                             endY: 0.12)    // how close to the top you want to stop
//            .zIndex(2) // make sure it renders above the rabbits
//        }
//    }
//}

#Preview(
    RisingMemoryStar1(), body: <#@MainActor () -> any View#>
})
