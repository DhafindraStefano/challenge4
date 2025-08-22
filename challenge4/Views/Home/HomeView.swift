//
//  HomeView.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 19/08/25.
//

import SwiftUI
import Lottie

struct HomeView: View {
    @State private var daysCount : Int = 1
    @State private var daysTotal: Int = 30
    @State private var offsetAmount : CGFloat = -150
    @State private var showHowNVCView = false
    var body: some View {
        NavigationStack{
            ZStack{
                //First Layer
                VStack{
                    Image("Background")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 2565, height: 908.09)
                        .offset(x:offsetAmount, y: -9)
                        .ignoresSafeArea()
                        .onAppear {
                                            withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)) {
                                                offsetAmount = 500 // Adjust as needed
                                            }
                                        }

                }
                
                //Need to figure out how to scatter the stars and the Moon, first layer
                //Second layer
//                StarView()
                
                //Third Layer
//                VStack {
//                    Image("MoonBase")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 440, height: 246)
//                        .offset(y: 300 )
//                        .ignoresSafeArea(.all)
//                }
                
                //FourthLayer
//                VStack{
//                    ZStack() {
//                        Image("ProgressBar")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 177, height: 65)
//
//                        HStack(spacing: 0) {
//                            Text ("\(daysCount)")
//                                .font(.system(size:28, design: .rounded ))
//                                .fontWeight(.bold)
//                                .foregroundStyle(.white)
//                                .offset(x: 58, y:-6)
//                            Text("\\\\\(daysTotal)")
//                                .font(.system(size:28, design: .rounded ))
//                                .fontWeight(.bold)
//                                .multilineTextAlignment(.center)
//                                .foregroundStyle(
//                                    .white
//                                    .opacity(0.3))
//                                .offset(x: 58, y:-6)
//                        }.frame(maxWidth:148, alignment: .topLeading)
//                    }.frame(width: 353, height: 70, alignment: .topLeading)
//                    .padding(EdgeInsets(top:0, leading:20, bottom: 8, trailing: 20))
//                    
//
//                    ZStack {
//                        Image("ChildStone")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 210.32, height: 69)
//                            .offset(x:70,y:405)
//                        LottieView(name: "rabbit talk child", // the name is the name of the .json file
//                                   loopMode: .loop, contentMode: .scaleAspectFit, speed: 1.0)
//                        .frame(width: 134, height: 173)
//                        .scaleEffect(0.14)
//                        .offset(y: 320)
//                        
//                        Image("ParentStone")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 99.84, height: 65.69)
//                            .offset(x:-90,y:405)
//                        LottieView(name: "rabbit talk mom", // the name is the name of the .json file
//                                   loopMode: .loop, contentMode: .scaleAspectFit, speed: 1.0)
//                        .frame(width: 163, height: 207)
//                        .scaleEffect(0.17)
//                        .offset(x:-30, y: 310)
//                        
//                    }
//                    
//                }.frame(maxWidth: 353, alignment: .topLeading)
                
                //Fourth Layer
                        
                        
                    
//                    Button{
//                       showHowNVCView = true
//                    }label:{
//                        Image("StartTalkBtn")
//                            .offset(x:10, y:350 )
//                    }
//                    Spacer()
//                }.navigationDestination(isPresented: $showHowNVCView) {
//                    HowNVCView()
//                }
               
                }.background(.red)
                .safeAreaInset(edge: .bottom) {
                Button { showHowNVCView = true } label: { Image("StartTalkBtn") }
                  .padding(.bottom, 12)
              }
              .toolbar(.hidden, for: .navigationBar) // if you want no bar
              .navigationDestination(isPresented: $showHowNVCView) { HowNVCView() } // iOS 17+
            }
            .background(Color("AppBg"), ignoresSafeAreaEdges: .all)
    }
}

#Preview {
    HomeView()
}
