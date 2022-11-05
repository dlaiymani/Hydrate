//
//  WeekView.swift
//  Hydrate
//
//  Created by David Laiymani on 02/09/2022.
//

import SwiftUI

struct WeekView: View {
   // private var daysOfTheWeek = ["M", "T", "W", "T", "F", "S", "S"]
    private var daysOfTheWeek:[String] = []
        
    init() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let dayOfWeek = calendar.component(.weekday, from: today)
        let days = calendar.range(of: .weekday, in: .weekOfYear, for: today)!
            .compactMap { calendar.date(byAdding: .day, value: $0 - dayOfWeek+1, to: today) }
        let formatter = DateFormatter()
        formatter.dateFormat = "eeee"
        for date in days {
            let day = formatter.string(from: date)
            daysOfTheWeek.append(day.first!.uppercased())
        }
    }
    
    var body: some View {
        HStack {
            ForEach(daysOfTheWeek, id: \.self) { day in
                if day == "F" {
                    CircleDayView(volumeInPercent: 33, day: day, currentDay: true)
                } else {
                    CircleDayView(volumeInPercent: 33, day: day, currentDay: false)

                }
            }
        }
        .scaleEffect(0.75)
    }
}

struct WeekView_Previews: PreviewProvider {
    static var previews: some View {
        WeekView()
    }
}
