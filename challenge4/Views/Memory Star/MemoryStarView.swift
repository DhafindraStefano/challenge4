//
//  MemoryStarView.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 19/08/25.
//

import SwiftUI

struct MemoryStarView: View {
    @State private var daysCount: Int = 0
    @State private var daysTotal: Int = 30
    @State private var navigateToHome = false
    
    @State private var offsetAmount: CGFloat = 0
    
    var body: some View {
        NavigationStack {
            if navigateToHome {
                HomeView(isClickedInitially: true)
                    .navigationBarBackButtonHidden(true)
            } else {
                GeometryReader { geo in
                    ZStack {
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
                        .offset(x: geo.size.width * -0.37, y: geo.size.height * 0.25)
                        .ignoresSafeArea()
                        
                        // Rabbits centered
                        VStack {
                            Spacer()
                            ZStack {
                                LottieView(
                                    name: "rabbit mom star",
                                    loopMode: .loop,
                                    contentMode: .scaleAspectFit,
                                    speed: 1.0
                                )
                                .frame(width: geo.size.width * 0.35, height: geo.size.height * 0.25)
                                .scaleEffect(0.17)
                                .offset(x: geo.size.width * -0.6, y: geo.size.height * 0.19)
                                
                                LottieView(
                                    name: "rabbit child star",
                                    loopMode: .loop,
                                    contentMode: .scaleAspectFit,
                                    speed: 1.0
                                )
                                .frame(width: geo.size.width * 0.3, height: geo.size.height * 0.2)
                                .scaleEffect(x: -0.14, y: 0.14)
                                .offset(x: geo.size.width * -0.15, y: geo.size.height * 0.19)
                                
                                RisingStar1()
                                    .offset(x: geo.size.width * -0.37)
                                    .allowsHitTesting(false)
                                    .accessibilityLabel("Rising memory star animation")
                                    .accessibilityAddTraits(.isImage)
                                
                                VStack {
                                    Spacer()
                                    
                                    HStack {
                                        Text("You Collect")
                                            .font(.title)
                                            .fontDesign(.rounded)
                                            .fontWeight(.regular)
                                            .foregroundStyle(.white)
                                        Text("Memory")
                                            .font(.system(size: 28, design: .rounded))
                                            .fontWeight(.regular)
                                            .foregroundStyle(Color("MemoryFontColor"))
                                    }
                                    
                                    HStack {
                                        Text("Star")
                                            .font(.title)
                                            .fontDesign(.rounded)
                                            .fontWeight(.regular)
                                            .foregroundStyle(Color("MemoryFontColor"))
                                        Text("together")
                                            .font(.system(size: 28, design: .rounded))
                                            .fontWeight(.regular)
                                            .foregroundStyle(.white)
                                    }
                                }
                                .accessibilityLabel("You collect Memory Star together")
                                .offset(x: geo.size.width * -0.369, y: geo.size.height * 0.15)
                            }
                            
                            Spacer().frame(height: geo.size.height * 0.25)
                        }
                    }
                    .background(
                        Image("Background")
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea()
                            .offset(x: offsetAmount, y: -geo.size.height * 0.04)
                            .onAppear {
                                offsetAmount = -geo.size.width * 0.3
                                withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
                                    offsetAmount = geo.size.width * 0.8
                                }
                            }
                    )
                    .background(Color("AppBg"), ignoresSafeAreaEdges: .all)
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        UIAccessibility.post(notification: .announcement, argument: "Memory collected, returning to Home screen")
                        withAnimation(.none) {
                            navigateToHome = true
                        }
                    }
                }
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    MemoryStarView()
}

//struct MemoryStarView: View {
//    @State private var daysCount: Int = 0
//    @State private var daysTotal: Int = 30
//    @State private var navigateToHome = false
//    
//    @State private var offsetAmount: CGFloat = 0
//    
//    var body: some View {
//        NavigationStack {
//            GeometryReader { geo in
//                ZStack {
//                    VStack {
//                        HStack {
//                            Spacer()
//                            Image("FullMoon")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: geo.size.width * 0.18)
//                                .padding(.top, geo.size.height * 0.2)
//                                .padding(.trailing, geo.size.width * 0.9)
//                        }
//                        Spacer()
//                    }
//                    
//                    VStack {
//                        Spacer()
//                        Image("MoonwithRock")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: geo.size.width * 1.8)
//                    }
//                    .offset(x: geo.size.width * -0.37, y: geo.size.height * 0.25)
//                    .ignoresSafeArea()
//                    // Rabbits centered
//                    VStack {
//                        Spacer()
//                        ZStack {
//                            LottieView(
//                                name: "rabbit mom star",
//                                loopMode: .loop,
//                                contentMode: .scaleAspectFit,
//                                speed: 1.0
//                            )
//                            .frame(width: geo.size.width * 0.35, height: geo.size.height * 0.25)
//                            .scaleEffect(0.17) // keep scaling responsive
//                            .offset(x: geo.size.width * -0.6, y: geo.size.height * 0.19) // relative offset
//                            
//                            LottieView(
//                                name: "rabbit child star",
//                                loopMode: .loop,
//                                contentMode: .scaleAspectFit,
//                                speed: 1.0
//                            )
//                            .frame(width: geo.size.width * 0.3, height: geo.size.height * 0.2)
//                            .scaleEffect(x: -0.14, y: 0.14)
//                            .offset(x: geo.size.width * -0.15, y: geo.size.height * 0.19)
//                            
//                            RisingStar1()
//                                .offset(x: geo.size.width * -0.37)
//                                .allowsHitTesting(false)
//                            VStack {
//                                Spacer()
//                                
//                                HStack {
//                                    Text("You Collect")
//                                        .font(.title)
//                                        .fontDesign(.rounded)
//                                        .fontWeight(.regular)
//                                        .foregroundStyle(.white)
//                                    Text("Memory")
//                                        .font(.system(size: 28, design: .rounded))
//                                        .fontWeight(.regular)
//                                        .foregroundStyle(Color("MemoryFontColor"))
//                                }
//                                
//                                HStack {
//                                    Text("Star")
//                                        .font(.title)
//                                        .fontDesign(.rounded)
//                                        .fontWeight(.regular)
//                                        .foregroundStyle(Color("MemoryFontColor"))
//                                    Text("together")
//                                        .font(.system(size: 28, design: .rounded))
//                                        .fontWeight(.regular)
//                                        .foregroundStyle(.white)
//                                }
//                            }
//                            .offset(x: geo.size.width * -0.369, y: geo.size.height * 0.15)
//                        }
//
//                        Spacer().frame(height: geo.size.height * 0.25)
//                    }
//                }
//                .background(
//                    Image("Background")
//                        .resizable()
//                        .scaledToFill()
//                        .ignoresSafeArea()
//                        .offset(x: offsetAmount, y: -geo.size.height * 0.04)
//                        .onAppear {
//                            // Start from -width * 0.3 and move across the full width
//                            offsetAmount = -geo.size.width * 0.3
//                            withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
//                                offsetAmount = geo.size.width * 0.8
//                            }
//                        }
//                )
//                .background(Color("AppBg"), ignoresSafeAreaEdges: .all)
//            }
//            .onAppear {
//                // Navigate to HomeView after 5s
//                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//                    var transaction = Transaction()
//                    transaction.disablesAnimations = true
//                    withTransaction(transaction) {
//                        navigateToHome = true
//                    }
//                }
//            }
//            .navigationDestination(isPresented: $navigateToHome) {
//                HomeView(isClickedInitially: true)
//                    .transaction { $0.disablesAnimations = true }
//                    .navigationBarBackButtonHidden(true)
//            }
//
//            .navigationBarBackButtonHidden(true)
//        }
//    }
//}
//
//#Preview {
//    MemoryStarView()
//}


