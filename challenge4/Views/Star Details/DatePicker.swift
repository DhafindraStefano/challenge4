//
//  DatePicker.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 21/08/25.
//

import SwiftUI

struct DatePicker: View {
    @State private var selectedDate = Date()

    var body: some View {
        HStack(spacing: 16) {
            // Left chevron: go to previous day
            Button(action: {
                withAnimation {
                    selectedDate = Calendar.current.date(byAdding: .day,
                                                         value: -1,
                                                         to: selectedDate) ?? selectedDate
                }
            }) {
                Image(systemName: "chevron.left")
                    .font(.title2)                // size similar to other icons
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
            }

            // Date (top) and day name (bottom)
            VStack(spacing: 4) {
                Text(dateString)
                    .font(.title)                 // bigger font for the date
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                Text(dayString)
                    .font(.headline)              // smaller font for the day name
                    .foregroundColor(.white)
                    .fontWeight(.light)
            }

            // Right chevron: go to next day
            Button(action: {
                withAnimation {
                    selectedDate = Calendar.current.date(byAdding: .day,
                                                         value: 1,
                                                         to: selectedDate) ?? selectedDate
                }
            }) {
                Image(systemName: "chevron.right")
                    .font(.title2)
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
            }
        }
        .padding() // adjust padding as needed
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
}

#Preview {
    DatePicker()
}
