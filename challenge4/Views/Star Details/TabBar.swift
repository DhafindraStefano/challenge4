//
//  TabBar.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 21/08/25.
//

import SwiftUI

struct TabBar: View {
    enum Tab: String, CaseIterable {
        case parent = "Parent"
        case child  = "Child"
        case games  = "Games"
    }

    @State private var selectedTab: Tab = .parent
    @Namespace private var animation

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.self) { tab in
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        selectedTab = tab
                    }
                }) {
                    Text(tab.rawValue)
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(
                            ZStack {
                                if selectedTab == tab {
                                    Capsule()
                                        .fill(Color("EmotionBarColor"))
                                        .matchedGeometryEffect(id: "TAB_INDICATOR", in: animation)
                                }
                            }
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(4) // space inside the outer capsule
        .background(
            Capsule()
                .fill(Color("EmotionBarColorDropShadow"))
        )
        .padding(.horizontal, 20) // space between bar and screen edges
    }
}

#Preview {
    TabBar()
}
