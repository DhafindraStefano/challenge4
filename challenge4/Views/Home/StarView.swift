//
//  StarView.swift
//  challenge4
//
//  Created by Ardelia on 22/08/25.
//

//
//  HomeView.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 19/08/25.
//

import SwiftUI
import Lottie

struct StarView: View {
    @State private var daysCount : Int = 1
    @State private var daysTotal: Int = 30
    @State private var offsetAmount : CGFloat = -150
    @State private var showHowNVCView = false
    var body: some View {
        ZStack{
            VStack {
                Spacer()
                HStack {
                    Image("StarHome")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 79)
                    Spacer()
                    Image("FullMoon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 79, height: 79)
                }.padding(20)
                Spacer()
            }
            
        }.background(Color("AppBg"), ignoresSafeAreaEdges: .all)
                
    }
}

#Preview {
    StarView()
}
