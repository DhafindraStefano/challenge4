//
//  RisingStar2.swift
//  challenge4
//
//  Created by Ardelia on 25/08/25.
//
import SwiftUI

struct RisingMemoryStar1: View {
    var imageName = "StarHome"

    var startY: CGFloat = 0.62

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
        }.background(.black)
        .allowsHitTesting(false) // won’t block your buttons
    }
}

//import SwiftUI
//
//struct MemoryStarKeyframed: View {
//    // Values we animate with keyframes
//    struct Values {
//        var position = CGPoint.zero
//        var scale: CGFloat = 0.4
//        var glow: CGFloat = 0.0
//        var sparkle: CGFloat = 0.0
//    }
//
//    @State private var go = false
//
//    var body: some View {
//        GeometryReader { geo in
//            let cx = geo.size.width / 2
//            // tweak these to start between your rabbits and stop near the top
//            let start = CGPoint(x: cx, y: geo.size.height * 0.62)
//            let end   = CGPoint(x: cx, y: geo.size.height * 0.12)
//
//            KeyframeAnimator(initialValue: Values(), trigger: go) { _, v in
//                ZStack {
//                    // Your star image
//                    Image("StarHome")
//                        .resizable().scaledToFit()
//                        .frame(width: 56, height: 56)
//                        .position(v.position)
//                        .scaleEffect(v.scale)
//                        // soft glow that peaks on arrival
//                        .shadow(color: .white.opacity(0.25 + 0.75 * v.glow),
//                                radius: 8 + 20 * v.glow)
//
//                        // sparkle burst on arrival
//                        .overlay {
//                            Image(systemName: "sparkles")
//                                .symbolRenderingMode(.palette)
//                                .foregroundStyle(.white, .yellow)
//                                .opacity(v.sparkle)            // fade in/out
//                                .scaleEffect(1 + 0.8 * v.sparkle)
//                                .blendMode(.screen)            // bright pop
//                        }
//                }
//            } keyframes: { _ in
//                // 1) Move up in 1.2s
//                KeyframeTrack(\.position) {
//                    CubicKeyframe(start, duration: 0.0)
//                    LinearKeyframe(end,  duration: 1.2)
//                }
//                // 2) Grow while moving
//                KeyframeTrack(\.scale) {
//                    CubicKeyframe(0.4, duration: 0.0)
//                    LinearKeyframe(1.0, duration: 1.2)
//                }
//                // 3) Glow rises right after arrival, then settles
//                KeyframeTrack(\.glow) {
//                    CubicKeyframe(0.0, duration: 1.2)           // hold while traveling
//                    SpringKeyframe(1.0, duration: 0.5)          // burst
//                    LinearKeyframe(0.2, duration: 0.3)          // settle
//                }
//                // 4) Sparkle pops after arrival
//                KeyframeTrack(\.sparkle) {
//                    CubicKeyframe(0.0, duration: 1.2)           // wait
//                    LinearKeyframe(1.0, duration: 0.2)          // pop in
//                    LinearKeyframe(0.0, duration: 0.3)          // fade out
//                }
//            }
//            .onAppear { go.toggle() }
//        }
//        .allowsHitTesting(false) // decorative only
//    }
//}


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

#Preview{
    RisingMemoryStar1()
}
