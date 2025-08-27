//
//  RabbitsTalkingView.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 25/08/25.
//

import SwiftUI
import Lottie
import SwiftData

struct RabbitsTalkingViewHomePage: View {
    @State private var daysCount: Int = 0
    @State private var offsetAmount: CGFloat = -150
    @State private var showHowNVCView = false
    @State private var angle = Angle.zero
    @State private var showFallingStar = false
    @State private var showStarBackground = true
    @State private var starBackgroundOpacity: Double = 1.0
    @State private var isClicked: Bool
    
    init(isClickedInitially: Bool = false) {
        _isClicked = State(initialValue: isClickedInitially)
        _showFallingStar = State(initialValue: isClickedInitially)
        _showStarBackground = State(initialValue: !isClickedInitially)
        _starBackgroundOpacity = State(initialValue: isClickedInitially ? 0.0 : 1.0)
    }
        // MARK: - Parent / Child / Game Bindings
        @State var child: Bool = false
        @State var observationParent: RabitFaceObject? = nil
        @State var feelingParent: FeelingObject? = nil
        @State var needsParent: NeedObject? = nil
    
        @State var observationChild: RabitFaceObject? = nil
        @State var feelingChild: FeelingObject? = nil
        @State var needsChild: NeedObject? = nil
    
        @State var answerGame: FeelingObject? = nil
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \LogObject.date, order: .reverse) private var logs: [LogObject]
    
    private let calendar = Calendar.current
    
    private var currentMonthDaysTotal: Int {
        calendar.range(of: .day, in: .month, for: Date())?.count ?? 30
    }
    
    private var completedDaysCount: Int {
        let monthStart = calendar.date(from: calendar.dateComponents([.year, .month], from: Date()))!
        let monthEnd = calendar.date(byAdding: .month, value: 1, to: monthStart)!
        
        return logs.filter { log in
            log.date >= monthStart && log.date < monthEnd
        }.count
    }
    
    private func checkTodayLog() {
        let startOfDay = calendar.startOfDay(for: Date())
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let todayLogExists = logs.contains { log in
            log.date >= startOfDay && log.date < endOfDay
        }
        
        isClicked = todayLogExists
        daysCount = 2
    }
    
    var body: some View {
        NavigationStack{
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
                    if showStarBackground {
                        StarBackground(starImageName: "StarHome", count: daysCount, minSize: 10, maxSize: 26)
                            .frame(width: geo.size.width, height: geo.size.height)
                            .rotationEffect(angle)
                            .opacity(starBackgroundOpacity)
                            .offset(x: geo.size.width * -0.39, y: geo.size.height * 0)
                            .onAppear {
                                withAnimation(.linear(duration: 16).repeatForever(autoreverses: false)) {
                                    angle = .degrees(360)
                                }
                            }
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
                    

                    
                    // 🌠 Falling star overlay
                    if showFallingStar {
                        FallingStar()
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) {
                                    showFallingStar = false
                                    showStarBackground = true
                                    withAnimation(.easeIn(duration: 1.0)) {
                                        starBackgroundOpacity = 1.0
                                    }
                                }
                            }
                            .offset(x: geo.size.width * -0.39, y: geo.size.height * 0)
                    }

                    // 🌙 Progress bar pinned
                    VStack {
                        ProgressBarView(
                            daysCount: completedDaysCount,
                            daysTotal: currentMonthDaysTotal
                        )
                        .offset(x: geo.size.width * -0.39, y: geo.size.height * 0)
    //                    .frame(width: geo.size.width * 0.3)
                        .padding(.trailing, geo.size.width * 0.6)
                        .padding(.top, geo.size.height * 0.05)
                        Spacer()
                    }

                    // 🐇 Button pinned bottom
                    VStack {
                        Spacer()
                        TalkToRabbitBtn(showHowNVCView: $showHowNVCView, isClicked: $isClicked)
                            .padding(.bottom, geo.size.height * 0.1)
                    }
                    .offset(x: geo.size.width * -0.39, y: geo.size.height * 0)
                    .opacity(starBackgroundOpacity)
                    
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
            .navigationDestination(isPresented: $showHowNVCView) {
                HowNVCView(
                    observationParent: $observationParent,
                    feelingParent: $feelingParent,
                    needsParent: $needsParent,
                    observationChild: $observationChild,
                    feelingChild: $feelingChild,
                    needsChild: $needsChild,
                    answerGame: $answerGame,
                    child: $child
                )
            }

            .onAppear {
                checkTodayLog()
            }
        }
    }

}

#Preview {
    RabbitsTalkingViewHomePage()
}
