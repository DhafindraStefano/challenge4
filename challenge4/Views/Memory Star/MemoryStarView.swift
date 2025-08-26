//
//  MemoryStarView.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 19/08/25.
//

import SwiftUI

struct MemoryStarView: View {
    @State private var daysCount : Int = 0
    @State private var daysTotal: Int = 30
    @State private var offsetAmount : CGFloat = -150
    var body: some View {
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
            
            //Secon Layer
            VStack {
                Image("MoonBase")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 440, height: 246)
                    .offset(y: 300 )
                    .ignoresSafeArea(.all)
            }
            
            //Fourth Layer
            VStack{
                
                HStack(spacing:-50){
                    ZStack {
                        Image("ChildStone")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 210.32, height: 69)
                            .offset(x:70,y:555)
                        LottieView(name: "rabbit talk child", // the name is the name of the .json file
                                   loopMode: .loop, contentMode: .scaleAspectFit, speed: 1.0)
                        .frame(width: 134, height: 173)
                        .scaleEffect(0.14)
                        .offset(y: 470)
                        
                        Image("ParentStone")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 99.84, height: 65.69)
                            .offset(x:-90,y:550)
                        LottieView(name: "rabbit talk mom", // the name is the name of the .json file
                                   loopMode: .loop, contentMode: .scaleAspectFit, speed: 1.0)
                        .frame(width: 163, height: 207)
                        .scaleEffect(0.17)
                        .offset(x:-30, y: 460)
                    }
                    
                }
                
                VStack {
                    HStack {
                        Text("You Collect")
                            .font(.system(size:28, design: .rounded ))
                            .fontWeight(.regular)
                            .foregroundStyle(.white)
                            .offset(x: 5, y:500)
                        Text("Memory")
                            .font(.system(size:28, design: .rounded ))
                            .fontWeight(.regular)
                            .foregroundStyle(Color("MemoryFontColor"))
                            .offset(x: 5, y:500)
                    }
                    HStack {
                        Text("Star")
                            .font(.system(size:28, design: .rounded ))
                            .fontWeight(.regular)
                            .foregroundStyle(Color("MemoryFontColor"))
                            .offset(x: 5, y:500)
                        Text("together")
                            .font(.system(size:28, design: .rounded ))
                            .fontWeight(.regular)
                            .foregroundStyle(.white)
                            .offset(x: 5, y:500)
                    }
                    
                }
                Spacer()
            }
            
            
        }
        
    }
}

#Preview {
    MemoryStarView()
}
