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
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(haptics)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
