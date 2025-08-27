//
//  RabbitsTalkingView.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 25/08/25.
//

import SwiftUI
import Lottie

struct RabbitsTalkingView: View {
    @State private var offsetAmount: CGFloat = -150
    var body: some View {
        GeometryReader { geo in
            ZStack{
                VStack {
                    HStack {
                        Spacer()
                        Image("FullMoon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width * 0.18)
                            .padding(.top, geo.size.height * 0.2)
                            .padding(.trailing, geo.size.width * 0.9)
                    }
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    Image("MoonwithRock")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width * 1.8)
                }
                .offset(x: geo.size.width * -0.37, y: geo.size.height * 0.21)
                .ignoresSafeArea()
                
                // Rabbits centered
                VStack {
                    Spacer()
                    ZStack {
                        LottieView(name: "rabbit talk child", loopMode: .loop, contentMode: .scaleAspectFit, speed: 1.0)
                            .frame(width: geo.size.width * 0.3, height: geo.size.height * 0.2)
                            .scaleEffect(0.14)
                            .offset(x: geo.size.width * -0.4, y: geo.size.width * -0.12)
                        
                        LottieView(name: "rabbit talk mom", loopMode: .loop, contentMode: .scaleAspectFit, speed: 1.0)
                            .frame(width: geo.size.width * 0.35, height: geo.size.height * 0.25)
                            .scaleEffect(0.17)
                            .offset(x: geo.size.width * -0.5, y: geo.size.width * -0.12)
                    }
                    Spacer().frame(height: geo.size.height * 0.25)
                }

            }
            .ignoresSafeArea()
            .background(
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .offset(x: offsetAmount, y: -geo.size.height * 0.04)
                    .onAppear {
                        withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
                            offsetAmount = 500
                        }
                    }
            )
            .background(Color("AppBg"), ignoresSafeAreaEdges: .all)
            
        }
    }
}

#Preview {
    RabbitsTalkingView()
}
