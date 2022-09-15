//
//  ProfileView.swift
//  Hydrate
//
//  Created by David Laiymani on 14/09/2022.
//

import SwiftUI

enum Sex: String, CaseIterable, Identifiable {
    case F
    case M
    case O
    
    var id: Self { self }
}

enum Units: String, CaseIterable, Identifiable {
    case Kg
    case Oz
    
    var id: Self { self }
}


struct ProfileView: View {
    
    @Environment(\.dismiss) private var dismiss

    @State private var age = 30
    @State private var sex: Sex = .F
    @State private var weight = 70.0
    @State private var physcicalActivity = 2
    @State private var unit: Units = .Kg
    @State private var setAutomaticGoal = true
    @State private var goal = ""
    
    private var sexTab = ["F", "M", "O"]
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.purple)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        
    }
    
    var body: some View {
        List {
            Section("Personal Info") {
                HStack {
                    Text("Sex")
                    
                    Spacer()
                    
                    Picker("Sex", selection: $sex) {
                        ForEach(Sex.allCases) { sex in
                            Text(sex.rawValue)
                            
                        }
                    }
                    .frame(width: 150)
                }
                .pickerStyle(.segmented)
                .font(.title3)
                .foregroundColor(.purple)
                
                
                Picker("Age", selection: $age) {
                    ForEach(5 ..< 130) { number in
                        Text("\(number)")
                    }
                }
                .font(.title3)
                .foregroundColor(.purple)
                
                Picker("Weight", selection: $age) {
                    ForEach(20 ..< 200) { number in
                        Text("\(number) kg")
                    }
                }
                .font(.title3)
                .foregroundColor(.purple)
            }
            
            Section {
                HStack {
                    Text("Physical activity")
                    
                    Spacer()
                    
                    Picker("", selection: $physcicalActivity) {
                        ForEach(1..<6) { physic in
                            Text("\(physic)")
                        }
                    }
                    .frame(width: 170)
                }
                .pickerStyle(.segmented)
                .font(.title3)
                .foregroundColor(.purple)
            }
            
            Section {
                HStack {
                    Text("Units")
                    
                    Spacer()
                    
                    Picker("", selection: $unit) {
                        ForEach(Units.allCases) { unit in
                            Text("\(unit.rawValue)")
                        }
                    }
                    .frame(width: 120)
                }
                .pickerStyle(.segmented)
                .font(.title3)
                .foregroundColor(.purple)
            }
            
            
            Section("Goal") {
                Toggle("Set automatic goal", isOn: $setAutomaticGoal)
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                    .font(.title3)
                    .foregroundColor(.blue)
                if !setAutomaticGoal {
                    HStack {
                        Text("Goal")
                        Spacer()
                        TextField("Enter your goal", text: $goal)
                            .keyboardType(.decimalPad)
                            .frame(width: 120)
                            .multilineTextAlignment(.trailing)
                        Text("cl")
                    }
                    .font(.title3)
                    .foregroundColor(.blue)
                }
            }
        }
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "x.circle.fill")
                   //     .font(.title)
                        .foregroundColor(Color(.systemGray4))
                }
            }
        }
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProfileView()
        }
    }
}
