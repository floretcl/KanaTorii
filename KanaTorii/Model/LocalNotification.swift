//
//  LocalNotification.swift
//  KanaTorii
//
//  Created by Clément FLORET on 05/03/2021.
//

import Foundation
import SwiftUI

class LocalNotification: ObservableObject {
    var notifications = [Notification]()
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted == true && error == nil {
                print("Notifications permitted")
            } else {
                print("Notifications not permitted")
            }
        }
    }
    func sendNotification(title: String, subtitle: String?, body: String, weekday: Int?, hour: Int?, minute: Int?) {
        
        let content = UNMutableNotificationContent()
        content.title = title
        if let subtitle = subtitle {
            content.subtitle = subtitle
        }
        content.body = body
        
        var date = DateComponents()
        if weekday != 0 {
            date.weekday = weekday
        }
        date.hour = hour
        date.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
