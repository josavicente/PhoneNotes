//
//  NoteModel.swift
//  PhoneNotes
//
//  Created by Josafat Vicente Pérez on 29/10/2020.
//

import Foundation
import UIKit

struct NoteModel: Identifiable {
    
    var id: UUID
    var contactName: String
    var fromWho: Caller
    var dayToCall: NoteDate
    var timestamp: Date
    var telephone: PhoneNumber
    var note: String?
    
    init (){
        self.init(id: UUID(), contactName: "Name", note: "Take a note", fromWho: Caller.work, dayToCall: NoteDate(date: Date()), timestamp: Date(),
                  telephone: "+34999777888")
    }
    
    init(id: UUID?, contactName: String, note: String?, fromWho: Caller, dayToCall: NoteDate, timestamp: Date,
         telephone: String) {
        if let ident = id {
            self.id = ident
        }else{
            self.id = UUID()
        }
        self.contactName = contactName
        self.note = note
        self.fromWho = fromWho
        self.dayToCall = dayToCall
        self.timestamp = timestamp
        self.telephone = PhoneNumber.init(extractFrom: telephone)!
    }
    
    
    mutating func reset() {
        self = NoteModel()
    }
    
}


struct WidgetNoteData: Identifiable, Codable {
    
    var id: UUID
    var contactName: String
    var fromWho: Int16
    var dayToCall: Date
    var timestamp: Date
    var telephone: String
    var note: String?
    
    init (){
        self.init(id: UUID(), contactName: "Name", note: "Take a note", fromWho: Caller.work.rawValue, dayToCall: Date(), timestamp: Date(),
                  telephone: "+34999888777")
    }
    
    init(id: UUID?, contactName: String, note: String?, fromWho: Int16, dayToCall: Date, timestamp: Date,
         telephone: String) {
        if let ident = id {
            self.id = ident
        }else{
            self.id = UUID()
        }
        self.contactName = contactName
        self.note = note
        self.fromWho = fromWho
        self.dayToCall = dayToCall
        self.timestamp = timestamp
        self.telephone = telephone
    }
}
