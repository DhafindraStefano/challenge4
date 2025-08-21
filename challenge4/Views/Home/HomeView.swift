//
//  HomeView.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 19/08/25.
//

import SwiftUI
import Lottie

struct HomeView: View {
    @State private var daysCount : Int = 0
    @State private var daysTotal: Int = 30
    var body: some View {
        NavigationStack{
            ZStack{
                //Need to figure out how to scatter the stars and the Moon, first layer
                
                VStack{
                    
                    Image("StarHome")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 79)
                        .offset(x:-110,y:-70)
                    Image("FullMoon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 79, height: 79)
                        .offset(x:120,y:-189)
                }
                
                //Second Layer
                VStack {
                    Image("MoonBase")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 450)
                        .offset(y:300)
                        .ignoresSafeArea(.all)
                }
                
                //Third Layer
                VStack{
                    HStack{
                        ZStack {
                            Image("ProgressBar")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 177, height: 65)

                            HStack(spacing: 0) {
                                Text ("\(daysCount)")
                                    .font(.system(size:28, design: .rounded ))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                    .offset(x: 58, y:-6)
                                Text("\\\\\(daysTotal)")
                                    .font(.system(size:28, design: .rounded ))
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                    .foregroundStyle(
                                        .white
                                        .opacity(0.3))
                                    .offset(x: 58, y:-6)
                            }.frame(maxWidth:148, alignment: .topLeading)
                        }
                        Spacer()
                        Button() {
                            
                        } label: {
                            Image("SettingBtn")
                        }
                    }.padding(.horizontal, 20.0)
                    
                    HStack(spacing:-50){
                        ZStack {
                            Image("ChildStone")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 210.32, height: 69)
                                .offset(x:130,y:365)
                            LottieView(name: "rabbit talk child", // the name is the name of the .json file
                                       loopMode: .loop, contentMode: .scaleAspectFit, speed: 1.0)
                            .frame(width: 134, height: 173)
                            .offset(x:500,y: 2200)
                            .scaleEffect(0.13)
                            Image("ParentStone")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 99.84, height: 65.69)
                                .offset(x:-30,y:365)
                        }
                        
                        
//                            .scaleEffect(1, anchor: .trailing)
            


                            Image("ChildBunny")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 163, height: 250)
                                .offset(y:280)
                        
                        
                    }
                    
                    Button(){
                        
                    }label:{
                        Image("StartTalkBtn")
                            .offset(x:10, y:320 )
                    }
                    Spacer()
                }
               
                
            }
            .background(Color("AppBg"))
    
        }
    }
}

#Preview {
    HomeView()
}
