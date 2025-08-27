//
//  DatePicker.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 21/08/25.
//

import SwiftUI

struct DatePicker: View {
    @Binding var selectedDate: Date
    let onPreviousDay: () -> Void
    let onNextDay: () -> Void
    let isCompleted: Bool
    
    init(selectedDate: Binding<Date>, isCompleted: Bool = false, onPreviousDay: @escaping () -> Void = {}, onNextDay: @escaping () -> Void = {}) {
        _selectedDate = selectedDate
        self.isCompleted = isCompleted
        self.onPreviousDay = onPreviousDay
        self.onNextDay = onNextDay
    }

    var body: some View {
        HStack(spacing: 16) {
            // Left chevron: go to previous day
            Button(action: {
                onPreviousDay()
            }) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(isCompleted ? .black : .white)
//                    .fontWeight(.heavy)
            }
            .accessibilityLabel("Previous day")
            .accessibilityHint("Select the previous day")

            // Date (top) and day name (bottom) with hidden reference text underneath
            ZStack {
                // Your visible date/day
                VStack(spacing: 2) {
                    Text(dateString)
                        .font(.title)
                        .foregroundColor(isCompleted ? .black : .white)
                        .fontWeight(.heavy)
                    Text(dayString)
                        .font(.headline)
                        .foregroundColor(isCompleted ? .black : .white)
                        .fontWeight(.light)
                }
                .accessibilityElement(children: .combine)
                .accessibilityLabel("\(dayString), \(dateString) of \(monthString) \(yearString)")
                .accessibilityHint("Current selected date")
                // Hidden placeholder: ensures consistent width for longest possible strings
                VStack(spacing: 2) {
                    Text("31")
                        .font(.title)
                        .fontWeight(.heavy)
                    Text("Wednesday")
                        .font(.headline)
                        .fontWeight(.light)
                }
                .opacity(0)
            }

            // Right chevron: go to next day (disabled if current date is today or later)
            Button(action: {
                onNextDay()
            }) {
                Image(systemName: "chevron.right")
                    .font(.title2)
                    .foregroundColor(isAtPresentDay ? .gray : (isCompleted ? .black : .white))
//                    .fontWeight(.heavy)
            }
            .accessibilityLabel("Next day")
            .accessibilityHint(isAtPresentDay ? "Cannot select a future date" : "Select the next day")
            .disabled(isAtPresentDay)
        }
        .padding()
    }

    /// Two-digit day of month (01, 02, etc.)
    private var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: selectedDate)
    }

    /// Full weekday name (Monday, Tuesday, etc.)
    private var dayString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: selectedDate)
    }
    
    /// Check if selected date is today or later (prevent future navigation)
    private var isAtPresentDay: Bool {
        let calendar = Calendar.current
        return calendar.isDate(selectedDate, inSameDayAs: Date()) || selectedDate > Date()
    }
    private var monthString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter.string(from: selectedDate)
    }

    private var yearString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter.string(from: selectedDate)
    }

}

//#Preview {
//    @State var previewDate = Date()
//    return DatePicker(selectedDate: $previewDate, isCompleted: false, onPreviousDay: {}, onNextDay: {}).background(.blue)
//}
