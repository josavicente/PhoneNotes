//
//  Extensions.swift
//  PhoneNotes
//
//  Created by Josafat Vicente Pérez on 29/10/2020.
//

import Foundation
import SwiftUI

extension View{
    
//    func saveContext(context: NSManagedObjectContext, phoneNotes: FetchedResults<PhoneNote>) {
//        
//        if context.hasChanges {
//            
//            do {
//                try context.save()
//                // Guardamos localmente de forma compartida
//                var subsData : [Widget] = []
//                for subs in subscriptions {
//                    let subsMod = WidgetSubscriptionData(id: subs.id, name: subs.wrappedName, price: subs.price, currency: subs.curr, nextPay: subs.dateNextPay, dateLastUpdate: subs.dateLastUpdate, cycle: subs.subscriptionCycle, color: subs.colorPalette, type: subs.subscriptionType, paymentMethod: subs.payment)
//                    subsData.append(subsMod)
//                }
//                var rates : [WidgetRatesData] = []
//                
//                for rate in ratesConversion {
//                    let rateMod = WidgetRatesData(id: rate.id, name: rate.name!, base: rate.base!, value: rate.value)
//                    rates.append(rateMod)
//                }
//                saveWidgetSubsData(widgetData: subsData)
//                saveWidgetRatesData(widgetData: rates)
//                WidgetCenter.shared.reloadTimelines(ofKind: "BulletsAppWidget")
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//        
//        
//    }
//    
//    func deleteSubscription(subs: Subscription, context: NSManagedObjectContext, subscriptions: FetchedResults<Subscription>) {
//        if let notification = subs.notificationID{
//            subs.removeNotification(with: notification.uuidString)
//        }
//        context.delete(subs)
//        
//        context.performAndWait {
//            do {
//                // Guardamos localmente de forma compartida
//                try context.save()
//                var subsData : [WidgetSubscriptionData] = []
//                for subs in subscriptions {
//                    let subsMod = WidgetSubscriptionData(id: subs.id, name: subs.wrappedName, price: subs.price, currency: subs.curr, nextPay: subs.dateNextPay, dateLastUpdate: subs.dateLastUpdate, cycle: subs.subscriptionCycle, color: subs.colorPalette, type: subs.subscriptionType, paymentMethod: subs.payment)
//                    subsData.append(subsMod)
//                }
//                var rates : [WidgetRatesData] = []
//                
//                for rate in ratesConversion {
//                    let rateMod = WidgetRatesData(id: rate.id, name: rate.name!, base: rate.base!, value: rate.value)
//                    rates.append(rateMod)
//                }
//                saveWidgetSubsData(widgetData: subsData)
//                saveWidgetRatesData(widgetData: rates)
//                WidgetCenter.shared.reloadTimelines(ofKind: "BulletsAppWidget")
//            } catch {
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//        WidgetCenter.shared.reloadTimelines(ofKind: "BulletsAppWidget")
//    }
//    
//    func saveWidgetSubsData(widgetData: [WidgetSubscriptionData]) {
//        let documentsDirectory = FileManager().containerURL(forSecurityApplicationGroupIdentifier: AppGroup.ruin.rawValue)
//        let archiveURL = documentsDirectory?.appendingPathComponent("widgetsSubsData.json")
//        let encoder = JSONEncoder()
//        if let dataToSave = try? encoder.encode(widgetData) {
//            do {
//                try dataToSave.write(to: archiveURL!)
//            } catch {
//                // TODO: ("Error: Can't save Counters")
//                return;
//            }
//        }
//    }
//    
//    func loadWidgetSubsData() -> [WidgetSubscriptionData] {
//        let documentsDirectory = FileManager().containerURL(forSecurityApplicationGroupIdentifier: AppGroup.ruin.rawValue)
//        guard let archiveURL = documentsDirectory?.appendingPathComponent("widgetsSubsData.json") else { return [WidgetSubscriptionData]() }
//        
//        guard let codeData = try? Data(contentsOf: archiveURL) else { return [] }
//        
//        let decoder = JSONDecoder()
//        
//        let loadedWidgetData = (try? decoder.decode([WidgetSubscriptionData].self, from: codeData)) ?? [WidgetSubscriptionData]()
//        
//        return loadedWidgetData
//    }
}
