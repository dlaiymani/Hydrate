//
//  WeekView.swift
//  Hydrate
//
//  Created by David Laiymani on 02/09/2022.
//

import SwiftUI

struct WeekView: View {
    private var daysOfTheWeek = ["M", "T", "W", "T", "F", "S", "S"]
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
