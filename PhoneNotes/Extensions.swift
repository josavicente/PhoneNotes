//
//  Extensions.swift
//  PhoneNotes
//
//  Created by Josafat Vicente Pérez on 23/09/2020.
//

import Foundation
import UIKit
import SwiftUI
import WidgetKit
import CoreData

class DataDetector {

    private class func _find(all type: NSTextCheckingResult.CheckingType,
                             in string: String, iterationClosure: (String) -> Bool) {
        guard let detector = try? NSDataDetector(types: type.rawValue) else { return }
        let range = NSRange(string.startIndex ..< string.endIndex, in: string)
        let matches = detector.matches(in: string, options: [], range: range)
        loop: for match in matches {
            for i in 0 ..< match.numberOfRanges {
                let nsrange = match.range(at: i)
                let startIndex = string.index(string.startIndex, offsetBy: nsrange.lowerBound)
                let endIndex = string.index(string.startIndex, offsetBy: nsrange.upperBound)
                let range = startIndex..<endIndex
                guard iterationClosure(String(string[range])) else { break loop }
            }
        }
    }

    class func find(all type: NSTextCheckingResult.CheckingType, in string: String) -> [String] {
        var results = [String]()
        _find(all: type, in: string) {
            results.append($0)
            return true
        }
        return results
    }

    class func first(type: NSTextCheckingResult.CheckingType, in string: String) -> String? {
        var result: String?
        _find(all: type, in: string) {
            result = $0
            return false
        }
        return result
    }
}

// MARK: PhoneNumber

struct PhoneNumber {
    private(set) var number: String
    init?(extractFrom string: String) {
        guard let phoneNumber = PhoneNumber.first(in: string) else { return nil }
        self = phoneNumber
    }

    private init (string: String) { self.number = string }
    
    func getNumber() -> String {
        return self.number
    }
    func makeACall() {
        guard let url = URL(string: "tel://\(number.onlyDigits())"),
            UIApplication.shared.canOpenURL(url) else { return }
        if #available(iOS 10, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }

    static func extractAll(from string: String) -> [PhoneNumber] {
        DataDetector.find(all: .phoneNumber, in: string)
            .compactMap {  PhoneNumber(string: $0) }
    }

    static func first(in string: String) -> PhoneNumber? {
        guard let phoneNumberString = DataDetector.first(type: .phoneNumber, in: string) else { return nil }
        return PhoneNumber(string: phoneNumberString)
    }
}

extension PhoneNumber: CustomStringConvertible { var description: String { number } }

// MARK: String extension

extension String {

    // MARK: Get remove all characters exept numbers

    func onlyDigits() -> String {
        let filtredUnicodeScalars = unicodeScalars.filter { CharacterSet.decimalDigits.contains($0) }
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }

    var detectedPhoneNumbers: [PhoneNumber] { PhoneNumber.extractAll(from: self) }
    var detectedFirstPhoneNumber: PhoneNumber? { PhoneNumber.first(in: self) }
}
extension Date {
    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss"
        return formatter.string(from: date)
    }
}

extension View{
    
    func saveContext(context: NSManagedObjectContext, phoneNotes: FetchedResults<PhoneNote>) {

        if context.hasChanges {

            do {
                try context.save()
                // Guardamos localmente de forma compartida
                var notesData : [WidgetNoteData] = []
                for note in phoneNotes {
                    let noteMod = WidgetNoteData(id: note.id, contactName: note.contactName!, note: note.note, fromWho: note.fromWho, dayToCall: note.daytoCall!, timestamp: note.timestamp!, telephone: note.telephone! )
                    notesData.append(noteMod)
                }
                saveWidgetNotesData(widgetData: notesData)
                WidgetCenter.shared.reloadTimelines(ofKind: "PhoneNotesAppWidget")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }


    }

    func deleteSubscription(note: PhoneNote, context: NSManagedObjectContext, phoneNotes: FetchedResults<PhoneNote>) {
        
        context.delete(note)

        context.performAndWait {
            do {
                // Guardamos localmente de forma compartida
                try context.save()
                var notesData : [WidgetNoteData] = []
                for note in phoneNotes {
                    let noteMod = WidgetNoteData(id: note.id, contactName: note.contactName!, note: note.note, fromWho: note.fromWho, dayToCall: note.daytoCall!, timestamp: note.timestamp!, telephone: note.telephone! )
                    notesData.append(noteMod)
                }
                
                saveWidgetNotesData(widgetData: notesData)
                WidgetCenter.shared.reloadTimelines(ofKind: "BulletsAppWidget")
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        WidgetCenter.shared.reloadTimelines(ofKind: "BulletsAppWidget")
    }

    func saveWidgetNotesData(widgetData: [WidgetNoteData]) {
        let documentsDirectory = FileManager().containerURL(forSecurityApplicationGroupIdentifier: AppGroup.ruin.rawValue)
        let archiveURL = documentsDirectory?.appendingPathComponent("widgetsNotesData.json")
        let encoder = JSONEncoder()
        if let dataToSave = try? encoder.encode(widgetData) {
            do {
                try dataToSave.write(to: archiveURL!)
            } catch {
                // TODO: ("Error: Can't save Counters")
                return;
            }
        }
    }

    func loadWidgetNotesData() -> [WidgetNoteData] {
        let documentsDirectory = FileManager().containerURL(forSecurityApplicationGroupIdentifier: AppGroup.ruin.rawValue)
        guard let archiveURL = documentsDirectory?.appendingPathComponent("widgetsNotesData.json") else { return [WidgetNoteData]() }

        guard let codeData = try? Data(contentsOf: archiveURL) else { return [] }

        let decoder = JSONDecoder()

        let loadedWidgetData = (try? decoder.decode([WidgetNoteData].self, from: codeData)) ?? [WidgetNoteData]()

        return loadedWidgetData
    }
}
