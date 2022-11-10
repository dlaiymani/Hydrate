//
//  ProfileView.swift
//  Hydrate
//
//  Created by David Laiymani on 14/09/2022.
//

import SwiftUI

enum Sex: Int, Identifiable {
    case F
    case M
    
    var id: Self { self }
}

extension Sex: CaseIterable {
    var label: String {
        switch self {
        case .F:
            return "F"
        case .M:
            return "M"
        
        }
    }
}

enum Units: Int, Identifiable {
    case cl
    case oz
    
    var id: Self { self }
}

extension Units: CaseIterable {
    var label: String {
        switch self {
        case .cl:
            return "cl"
        case .oz:
            return "oz"
        }
    }
}


extension ProfileEntity {
    
    var sex: Sex {
        get { return Sex.init(rawValue: Int(sexEnum)) ?? .F}
        set { sexEnum = Int16(newValue.rawValue)}
    }
    
    var units: Units {
        get { return Units.init(rawValue: Int(unitsEnum)) ?? .cl}
        set { unitsEnum = Int16(newValue.rawValue)}
    }
    
}

struct ProfileView: View {
    
    @AppStorage("currentPage") var currentPage = 1
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) var profile: FetchedResults<ProfileEntity>
    
    @State private var age: Int = 30
    @State private var sex: Sex = .F
    @State private var weight: Int = 70
    @State private var height: Int = 170

    @State private var physcicalActivity: Int = 2
    @State private var unit: Units = .cl
    @State private var automaticGoal = true
    @State private var goal = ""
    
    @State private var isShowingAlert = false
    @State private var alertMessage = ""
    
    
    private var sexTab = ["F", "M", "O"]
    var ages = Array(5...130)
    var weights = Array(20...200)
    var heights = Array(120...280)
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.accentColor)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Units") {
                    HStack {
                        Text("Units")
                        
                        Spacer()
                        
                        Picker("", selection: $unit) {
                            ForEach(Units.allCases) { unit in
                                Text(unit.label)
                            }
                        }
                        .frame(width: 120)
                    }
                    .pickerStyle(.segmented)
                    .font(.title3)
                    .foregroundColor(.purple)
                }
                
                
                Section {
                    Toggle("Set automatic goal", isOn: $automaticGoal)
                        .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                        .font(.title3)
                        .foregroundColor(.blue)
                        HStack {
                            Text("Goal")
                            Spacer()
                            
                            TextField("Enter your goal",
                                      text: $goal)
                                .keyboardType(.decimalPad)
                                .frame(width: 140)
                                .multilineTextAlignment(.trailing)
                                .disabled(automaticGoal)
                            Text("cl")
                        }
                        .font(.title3)
                        .foregroundColor(.blue)
                } header: {
                    Text("Goal")
                } footer: {
                    Text("Please read the FAQ section for more information on how the automatic goal is computed.")
                }

                
                if automaticGoal {
                    Section("Personal Info") {
                        HStack {
                            Text("Sex")
                            
                            Spacer()
                            
                            Picker("Sex", selection: $sex) {
                                ForEach(Sex.allCases) { sex in
                                    Text(sex.label).tag(sex)
                                }
                            }
                            .frame(width: 150)
                            .onChange(of: sex, perform: {_ in
                                if automaticGoal {
                                    goal = "\(computeGoal())"
                                }
                            })
                        }
                        .pickerStyle(.segmented)
                        .font(.title3)
                        .foregroundColor(.purple)
                        
                        
                        Picker("Age", selection: $age) {
                            ForEach(ages, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .font(.title3)
                        .foregroundColor(.purple)
                        .onChange(of: age, perform: {_ in
                            if automaticGoal {
                                goal = "\(computeGoal())"
                            }
                        })
                        
                        Picker("Height", selection: $height) {
                            ForEach(heights, id: \.self) {
                                Text("\($0) cm")
                            }
                        }
                        .font(.title3)
                        .foregroundColor(.purple)
                        .onChange(of: height, perform: {_ in
                            if automaticGoal {
                                goal = "\(computeGoal())"
                            }
                        })
                        
                        Picker("Weight", selection: $weight) {
                            ForEach(weights, id: \.self) {
                                Text("\($0) kg")
                            }
                        }
                        .font(.title3)
                        .foregroundColor(.purple)
                        .onChange(of: weight, perform: {_ in
                            if automaticGoal {
                                goal = "\(computeGoal())"
                            }
                        })
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
                            .onChange(of: physcicalActivity, perform: {_ in
                                if automaticGoal {
                                    goal = "\(computeGoal())"
                                }
                            })
                        }
                        .pickerStyle(.segmented)
                        .font(.title3)
                        .foregroundColor(.purple)
                    }
                    
                }
            }
            .onChange(of: automaticGoal, perform: { newValue in
                if newValue {
                    goal = "\(computeGoal())"
                } else {
                    if let goalDouble = profile.first?.goal {
                        if goalDouble == 0.0 {
                            self.goal = ""
                        } else {
                            self.goal = "\(goalDouble)"
                        }
                    } else {
                        self.goal = ""
                    }
                }
            })
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if (goal.count == 0 && !automaticGoal) {
                            alertMessage = "Your must specify a value for your goal 💪"
                            isShowingAlert = true
                        } else {
                            if profile.count == 0 { // Add
                                let newProfileEntity = ProfileEntity(context: PersistenceController.shared.container.viewContext)
                                newProfileEntity.sex = self.sex
                                newProfileEntity.units = self.unit
                                newProfileEntity.age = Int16(self.age)
                                newProfileEntity.weight = Int16(self.weight)
                                newProfileEntity.automaticGoal = self.automaticGoal
                                newProfileEntity.activityLevel = Int16(self.physcicalActivity)
                                newProfileEntity.goal = Double(self.goal) ?? 0.0
                                PersistenceController.shared.save()
                            } else { // Edit
                                profile.first!.sex = self.sex
                                profile.first!.units = self.unit
                                profile.first!.age = Int16(self.age)
                                profile.first!.weight = Int16(self.weight)
                                profile.first!.automaticGoal = self.automaticGoal
                                profile.first!.activityLevel = Int16(self.physcicalActivity)
                                profile.first!.goal = Double(self.goal) ?? 0.0
                                do {
                                    let viewContext = profile.first!.managedObjectContext
                                    try viewContext?.save()
                                    
                                } catch {
                                    fatalError("Error \(error.localizedDescription)")
                                }
                                
                            }
                            currentPage = 4
                            dismiss()
                        }
                        
                       
                    } label: {
                        Text("Save")
                            .fontWeight(.bold)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .overlay(content: {
                                Capsule().fill(Color.purple.opacity(0.05))
                            })
                    }
                }
            }
        }
        .alert(isPresented: $isShowingAlert, content: {
            Alert(title: Text(alertMessage))
        })
        .onAppear {
            DispatchQueue.main.async {
                
                self.sex = profile.first?.sex ?? .M
                self.age = Int(profile.first?.age ?? 35)
                self.weight = Int(profile.first?.weight ?? 70)
                self.physcicalActivity = Int(profile.first?.activityLevel ?? 2)
                self.unit = profile.first?.units ?? .oz
                self.automaticGoal = profile.first?.automaticGoal ?? false
                if let goalDouble = profile.first?.goal {
                    self.goal = "\(goalDouble)"
                } else {
                    self.goal = ""
                }
            }
            
            if automaticGoal {
                goal = "\(computeGoal())"
            }
            
        }
        .onDisappear {
          
        }
    }
    
    
    func computeGoal() -> Int {
        var bmr: Double = 0.0
        var tdee: Double = 0.0
        
        if sex == .M {
            bmr = 66 + (13.7 * Double(weight)) + (5 * Double(height)) - (6.8 * Double(age))
        } else {
            bmr = 655 + (9.6 * Double(weight)) + (1.8 * Double(height)) - (4.7 * Double(age))
        }
        
        switch physcicalActivity {
        case 1:
            tdee = bmr * 1.2
        case 2:
            tdee = bmr * 1.375
        case 3:
            tdee = bmr * 1.55
        case 4:
            tdee = bmr * 1.725
        case 5:
            tdee = bmr * 1.9
        default:
            tdee = bmr

        }
        
        return Int(tdee) / 10
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProfileView()
        }
    }
}
