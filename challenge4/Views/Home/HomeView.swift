//
//  HomeView.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 19/08/25.
//

import SwiftUI

struct HomeView: View {
    @State private var daysCount : Int = 0
    @State private var daysTotal: Int = 30
    var body: some View {
        NavigationStack{
            ZStack{
                //Need to figure out how to scatter the stars and the Moon
                VStack{
                    Spacer()
                    Image("StarHome")
                    Image("FullMoon")
                    Spacer()
                    Spacer()
                    Spacer()
                }
                
                
                VStack {
                    Spacer()
                    Image("MoonHome")
                        .resizable()
                        .scaledToFit()
                }
                VStack{
                    HStack{
                        ZStack {
                            Image("ProgressBar")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 177, height: 65)
//                            The distance between the stetoscope and the text supposed to be 7px but Ardel haven't figured out how to do that. So
                            HStack(spacing: 0) {
                                Spacer()
                                Spacer()
                                Text ("\(daysCount)")
                                    .font(.system(size:28, design: .rounded ))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                Text("\\\\\(daysTotal)")
                                    .font(.system(size:28, design: .rounded ))
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                    .foregroundStyle(
                                        .white
                                        .opacity(0.3))
                                Spacer()
                            }.frame(maxWidth:148, alignment: .topLeading)
                        }
                        Spacer()
                        Button() {
                            
                        } label: {
                            Image("SettingBtn")
                        }
                    }.padding(.horizontal, 20.0)
                    
                    HStack(spacing:-50){
                            Image("MotherBunny")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 163, height: 222)
                                .offset(y:280)

                            Image("ChildBunny")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 163, height: 250)
                                .offset(y:280)
                        
                        
                    }
                    Spacer()
                    Button(){
                        
                    }label:{
                        Image("StartTalkBtn")
                            .offset( y:140 )
                    }
                    Spacer()
                }
               
                
            }
//            .background(Color("AppBg"))
    
        }
    }
}

#Preview {
    HomeView()
}
