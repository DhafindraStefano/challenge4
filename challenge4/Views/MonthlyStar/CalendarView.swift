//
//  CalendarView.swift
//  challenge4
//
//  Created by Levana on 21/08/25.
//
import SwiftUI
struct CalendarView: View {
    @State private var currentDate = Calendar.current.date(from: DateComponents(year: 2025, month: 1, day: 1)) ?? Date()
    private let calendar = Calendar.current
    
    // Month and Year
    private var monthYear: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM YYYY" //-> Add YYYY If you want to add year beside the month
        return formatter.string(from: currentDate)
    }
    
    // Get days in current month
    private var daysInMonth: [Date?] {
        guard let monthRange = calendar.range(of: .day, in: .month, for: currentDate),
              let firstDayOfMonth = calendar.dateInterval(of: .month, for: currentDate)?.start else {
            return []
        }
        
        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        var days: [Date?] = Array(repeating: nil, count: firstWeekday - 1)
        
        for day in monthRange {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstDayOfMonth) {
                days.append(date)
            }
        }
        return days
    }
    
    var body: some View {
        ZStack {
            Color(red: 7/255, green: 7/255, blue: 32/255)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Image("Rock")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
            }
            .ignoresSafeArea()
            
            VStack {
                // Header with back button and month navigation
                HStack {
                    BackButton()
                    
                    Spacer()
                    HStack(spacing: 8) {
                        Button(action: {
                            if let newDate = calendar.date(byAdding: .month, value: -1, to: currentDate) {
                                currentDate = newDate
                            }
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                        }
                        
                        Text(monthYear)// Shows "Jan 2025"
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                        Button(action: {
                            if let newDate = calendar.date(byAdding: .month, value: 1, to: currentDate) {
                                currentDate = newDate
                            }
                        }) {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                        }
                    }
                    
                    Spacer()
                    
                    Color.clear.frame(width: 44, height: 44)
                }
                .padding(.horizontal, 20)
             // .padding(.top, 20)
                .padding(.bottom, 30)
             //   Spacer()
                
                // Calendar container
                VStack(spacing: 0) {
                    // Days of week header
                    HStack {
                        ForEach(["S","M","T","W","T","F","S"], id: \.self) { day in
                            Text(day)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 118/255, green: 114/255, blue: 255/255))
                             // .foregroundColor(.white.opacity(0.9))
                                .frame(width: 39, height: 50)
                        }
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                    
                    // Calendar grid
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 18) {
                        ForEach(0..<daysInMonth.count, id: \.self) { index in
                            if let date = daysInMonth[index] {
                                let dayNumber = calendar.component(.day, from: date)
                                Text("\(dayNumber)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(width: 40, height: 50)
                            } else {
                                Text("")
                                    .frame(width: 40, height: 50)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
                .background(Color(red: 21/255, green: 20/255, blue: 80/255))
                .cornerRadius(20)
                .padding(.horizontal, 20)
                
                Spacer()
            }
            
        }
    }
}
#Preview {
    CalendarView()
}
