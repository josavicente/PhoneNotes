//
//  PhoneNotesApp.swift
//  PhoneNotes
//
//  Created by Josafat Vicente Pérez on 23/09/2020.
//

import SwiftUI
import HapticEngine

@main
struct PhoneNotesApp: App {
    
    let persistenceController = PersistenceController.shared
    let haptics = HapticEngine()
    var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(haptics)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(appState)
        }
    }
}

class AppState: ObservableObject {
    @Published var showActionSheet: Bool = false
}
