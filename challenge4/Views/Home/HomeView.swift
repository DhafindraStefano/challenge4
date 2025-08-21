//
//  HomeView.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 19/08/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                //Need to figure out how to scatter the stars
                Image("StarHome")
                
                VStack {
                    Spacer()
                    Image("MoonHome")
                        .resizable()
                        .scaledToFit()
                }
                VStack{
                    HStack{
                        Image("ProgressBar")
                        Spacer()
                        Button() {
                            
                        } label: {
                            Image("SettingBtn")
                        }
                    }.padding(.horizontal, 20.0)
                    Spacer()
                    
                }
                
                HStack{
                    
                }
                
            }
            .background(Color("AppBg"))
    
        }
    }
}

#Preview {
    HomeView()
}
