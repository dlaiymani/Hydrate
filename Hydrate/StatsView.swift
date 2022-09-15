//
//  StatsView.swift
//  Hydrate
//
//  Created by David Laiymani on 02/09/2022.
//

import SwiftUI
import Charts

enum StatsType: String, CaseIterable, Identifiable {
    case week
    case month
    case year
    
    var id: String { self.rawValue }
}

struct VolumeCount: Identifiable {
    let id = UUID()
    let weekday: Date
    let volume: Int
    //   let goal: Int
    
    init(day: String, volume: Int) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        
        self.weekday = formatter.date(from: day) ?? Date.distantPast
        self.volume = volume
        //      self.goal = goal
    }
    
    var weekdayString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        return  dateFormatter.string(from: weekday)
    }
    
    var shortDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return  dateFormatter.string(from: weekday)
    }
    
}

extension VolumeCount {
    static let currentWeek: [VolumeCount] = [
        VolumeCount(day: "20220717", volume: 1500),
        VolumeCount(day: "20220718", volume: 2000),
        VolumeCount(day: "20220719", volume: 0),
        VolumeCount(day: "20220720", volume: 0),
        VolumeCount(day: "20220721", volume: 300),
        VolumeCount(day: "20220722", volume: 3000),
        VolumeCount(day: "20220723", volume: 2000)
    ]
    
    static let currentWeekGoal: [VolumeCount] = [
        VolumeCount(day: "20220717", volume: 2000),
        VolumeCount(day: "20220718", volume: 2000),
        VolumeCount(day: "20220719", volume: 2000),
        VolumeCount(day: "20220720", volume: 2000),
        VolumeCount(day: "20220721", volume: 2000),
        VolumeCount(day: "20220722", volume: 2000),
        VolumeCount(day: "20220723", volume: 2000)
    ]
}


let weekData = [
    (conso: "Volume", data: VolumeCount.currentWeek),
    (conso: "Goal", data: VolumeCount.currentWeekGoal)
]

struct StatsView: View {
    
    @State var stateType: StatsType = .week
    
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
            
            NavigationStack {
                
                List {
                    VStack {
                        HStack {
                            Label("Hydratation", systemImage: "takeoutbag.and.cup.and.straw")
                                .foregroundStyle(Color.accentColor)
                            
                            Picker("", selection: $stateType) {
                                ForEach(StatsType.allCases) { type in
                                    Text(type.rawValue.capitalized)
                                        .tag(type)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                        
                        HStack {
                            Spacer()
                            Text("avg. 1000cl / day")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGray))
                        }
                        .padding(.bottom, 10)
                        
                        
                        Chart {
                            ForEach(weekData, id: \.conso) { element in
                                ForEach(element.data) {
                                    LineMark(
                                        x: .value("Day", $0.shortDay),
                                        y: .value("Workout(in minutes)", $0.volume))
                                    
                                }
                                .foregroundStyle(by: .value("Workout(type)", element.conso))
                                .symbol(by: .value("Workout(type)", element.conso))
                                
                            }
                        }
                        .frame(height: 250)
                    }
                    
                    Section {
                        VStack() {
                            
                            HStack {
                                Label("Trophy", systemImage: "medal")
                                    .foregroundStyle(Color.accentColor)
                                    .padding(.bottom)
                                Spacer()
                            }
                            
                            Image(systemName: "25.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.purple)
                                .padding(.bottom, 2)
                            
                            
                            Image(systemName: "trophy")
                                .font(.system(size: 50))
                                .foregroundColor(.yellow)
                                .padding(.bottom, 2)
                            
                            Text("Hydrate Days")
                                .foregroundColor(.yellow)
                                .font(.title2)
                                .padding(.bottom)
                          
                            HStack {
                                Text("Daily streaks")
                                Text("Weekly Streaks")
                                Text("Monthly Streaks")
                            }
                        }
                    }
                    
                }
                .navigationBarTitleDisplayMode(.large)
                .navigationBarTitle(Text("Stats"))
            }
        }
        
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
