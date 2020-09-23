//
//  DataTypes.swift
//  PhoneNotes
//
//  Created by Josafat Vicente Pérez on 23/09/2020.
//

import Foundation
import SwiftUI

enum Caller : Int16, CaseIterable {
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
            return Color.pink
        case .service:
            return Color.purple
        case .provider:
            return Color.orange
        case .unknown:
            return Color.green
        }
        
    }
    
}
