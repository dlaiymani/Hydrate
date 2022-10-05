//
//  HydrateApp.swift
//  Hydrate
//
//  Created by David Laiymani on 02/09/2022.
//

import SwiftUI

@main
struct HydrateApp: App {
    
    @Environment(\.scenePhase) var scenePhase
   // @AppStorage("theme") private var theme: Theme

    
    @StateObject private var recipientViewModel = RecipientsViewModel()
    let viewContext = PersistenceController.shared.container.viewContext
    
    var body: some Scene {
        WindowGroup {
            TabsView()
                .environment(\.managedObjectContext, viewContext)
                .environmentObject(recipientViewModel)
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
                
            case .background:
                print("Scene is in background")
              //  persistenceController.save()
            case .inactive:
                print("Scene is inactive")
            case .active:
                print("Scene is active")
            @unknown default:
                print("Apple must have changed something")
            }
        }
    }
}
