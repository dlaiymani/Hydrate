//
//  NotificationsView.swift
//  Hydrate
//
//  Created by David Laiymani on 07/11/2022.
//

import SwiftUI

struct NotificationsView: View {
    @AppStorage("nbOfNotifications") private var nbOfNotifications = 0
    @AppStorage("notificationsAreOn") private var notifsAreOn = false
    
    let notifCenter = UNUserNotificationCenter.current()

    var body: some View {
        VStack {
            List {
                Section(header: Text("")) {
                    Toggle(isOn: $notifsAreOn) {
                        Text("Notifications")
                            .font(.body)
                    }
                    .tint(.accentColor)
                    
                }
                Section(header: Text("Notifications per day")) {
                    Stepper(value: $nbOfNotifications,
                            in: 1...3,
                            step: 1)
                    {
                        Label("\(nbOfNotifications)", systemImage: "bell.badge")
                            .foregroundColor(.purple)
                            .font(.title3)
                    }
                    .disabled(notifsAreOn == false)
                    
                }
                
            }
            .onChange(of: notifsAreOn) {newValue in
                if newValue {
                    nbOfNotifications = 1
                    startNotifs()
                } else {
                    nbOfNotifications = 0
                    notifCenter.removeDeliveredNotifications(withIdentifiers: ["hydrateId"])
                    notifCenter.removePendingNotificationRequests(withIdentifiers: ["hydrateId", "hydrateId2", "hydrateId3"])
                }
                
            }
        }
        .navigationTitle("Notifications")
        
    }
    
    func startNotifs() {
        notifCenter.requestAuthorization(options: [.alert]) { result, error in
            if let error = error {
                print(error)
            } else {
                if result {
                    let content = UNMutableNotificationContent()
                    content.title = "Don't forget to drink water today 👍"
                    
                    var dateComp = DateComponents()
                    dateComp.hour = 9
                    dateComp.minute = 0
                    
                    var dateComp2 = DateComponents()
                    dateComp2.hour = 12
                    dateComp2.minute = 0
                    
                    var dateComp3 = DateComponents()
                    dateComp3.hour = 16
                    dateComp3.minute = 0
                    
                    
                    let trigger =
                    UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: true)
                    
                    let trigger2 =
                    UNCalendarNotificationTrigger(dateMatching: dateComp2, repeats: true)
                    
                    let trigger3 =
                    UNCalendarNotificationTrigger(dateMatching: dateComp3, repeats: true)
                    
                    let request = UNNotificationRequest(identifier: "hydrateId", content: content, trigger: trigger)
                    
                    let request2 = UNNotificationRequest(identifier: "hydrateId2", content: content, trigger: trigger2)
                    
                    let request3 = UNNotificationRequest(identifier: "hydrateId3", content: content, trigger: trigger3)
                    
                    
                    switch nbOfNotifications {
                    case 1:
                        notifCenter.add(request) {error in
                            if let error = error {
                                print(error)
                            }
                        }
                    case 2:
                        notifCenter.add(request) {error in
                            if let error = error {
                                print(error)
                            }
                        }
                        notifCenter.add(request2) {error in
                            if let error = error {
                                print(error)
                            }
                        }
                    case 3:
                        notifCenter.add(request) {error in
                            if let error = error {
                                print(error)
                            }
                        }
                        notifCenter.add(request2) {error in
                            if let error = error {
                                print(error)
                            }
                        }
                        notifCenter.add(request3) {error in
                            if let error = error {
                                print(error)
                            }
                        }
                    default:
                        break
                    }
                    
                } else {
                  //  self.nbOfNotifications = 0
                }
            }
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
