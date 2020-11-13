//
//  DataTypes.swift
//  PhoneNotes
//
//  Created by Josafat Vicente Pérez on 23/09/2020.
//

import Foundation
import SwiftUI

enum Caller : Int16, CaseIterable, Codable {
    case work = 1
    case family = 2
    case friend = 3
    case service = 4
    case provider = 5
    case unknown = 6
    
    init(type: Int16){
        switch type {
        case 1:
            self = .work
        case 2:
            self = .family
        case 3:
            self = .friend
        case 4:
            self = .service
        case 5:
            self = .provider
        case 6:
            self = .unknown
        default:
            self = .unknown
        }
    }
    
    var description : String {
        switch self {
        case .work:
            return NSLocalizedString("work", comment: "")
        case .family:
            return NSLocalizedString("family", comment: "")
        case .friend:
            return NSLocalizedString("friend", comment: "")
        case .service:
            return NSLocalizedString("service", comment: "")
        case .provider:
            return NSLocalizedString("provider", comment: "")
        case .unknown:
            return NSLocalizedString("unknown", comment: "")
        }
        
    }
    
    var icon : String {
        switch self {
        case .work:
            return "briefcase.fill"
        case .family:
            return "person.3.fill"
        case .friend:
            return "person.crop.square.fill"
        case .service:
            return "lightbulb.fill"
        case .provider:
            return "wrench.fill"
        case .unknown:
            return "person.crop.circle.fill.badge.questionmark"
        }
        
    }
    var color : Color {
        switch self {
        case .work:
            return Color.red
        case .family:
            return Color.yellow
        case .friend:
            return Color.blue
        case .service:
            return Color.purple
        case .provider:
            return Color.orange
        case .unknown:
            return Color.green
        }
        
    }
    
}

struct NoteDate: Codable {
    
    var completeDate : Date
    var day : Int
    var month : Int
    var year : Int
    var hour : Int
    var minute : Int
    var dateString : String
    
    init(date: Date){
        
        // Break a part date passed or current
        let components = Calendar.current.dateComponents([.month, .day, .year], from: date)
        
        if let day = components.day {
            self.day = day
        }else{
            self.day = Calendar.current.dateComponents([.day], from: Date()).day!
        }
        
        if let month = components.month {
            self.month = month
        }else{
            self.month = Calendar.current.dateComponents([.month], from: Date()).month!
        }
        
        if let year = components.year {
            self.year = year
        }else{
            self.year = Calendar.current.dateComponents([.year], from: Date()).year!
        }
        
        if let hour = components.hour {
            self.hour = hour
        }else{
            self.hour = Calendar.current.dateComponents([.hour], from: Date()).hour!
        }
        
        if let minute = components.minute {
            self.minute = minute
        }else{
            self.minute = Calendar.current.dateComponents([.minute], from: Date()).minute!
        }
        self.completeDate = date
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.dateFormat = "MMM d, yyyy"
        self.dateString = formatter.string(from: date)
    }
    
    func equals(date: NoteDate) -> Bool {
        
        if ( self.day == date.day) &&
            ( self.month == date.month ) &&
            ( self.year == date.year ) {
            return true
        } else {
            return false
        }
    }
    
    mutating func dateToString(){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.dateFormat = "MMM d, yyyy"
        self.dateString = formatter.string(from: self.completeDate)
    }
   
}

public enum AppGroup: String {
    case ruin = "group.code.josavicente.Notes"
    
    public var containerURL: URL {
        switch self {
        case .ruin:
            return FileManager.default.containerURL(
                forSecurityApplicationGroupIdentifier: self.rawValue)!
        }
    }
}

public extension URL {
    
    /// Returns a URL for the given app group and database pointing to the sqlite database.
    static func storeURL(for appGroup: String, databaseName: String) -> URL {
        guard let fileContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) else {
            fatalError("Shared file container could not be created.")
        }
        
        return fileContainer.appendingPathComponent("\(databaseName).sqlite")
    }
}
