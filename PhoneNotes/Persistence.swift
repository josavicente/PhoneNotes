//
//  Persistence.swift
//  PhoneNotes
//
//  Created by Josafat Vicente Pérez on 23/09/2020.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<10 {
            let newItem = PhoneNote(context: viewContext)
            newItem.contactName = "Name " + String(i)
            newItem.telephone = "Telephont " + String(i)
            newItem.note = "Extensive Note about the call, Extensive Note about the call, Extensive Note about the call, Extensive Note about the call, Extensive Note about the call"
            newItem.fromWho = Caller.unknown.rawValue
            newItem.timestamp = Date()
            newItem.id = UUID()
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "PhoneNotes")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}

extension PhoneNote {
    
    var caller: Caller {
        
        get {
            return Caller(rawValue: self.fromWho) ?? Caller.unknown
        }
        
        set {
            self.fromWho = newValue.rawValue
        }
    }
}
