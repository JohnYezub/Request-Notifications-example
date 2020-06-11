//
//  Notifications.swift
//  Request Notifications
//
//  Created by   admin on 11/06/20.
//  Copyright © 2020 Evgeny Ezub. All rights reserved.
//

import UIKit
import UserNotifications

class Notifications: NSObject, UNUserNotificationCenterDelegate {
    
    let notificationcenter = UNUserNotificationCenter.current()
    
    func requestNotification() {
            notificationcenter.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                print("Permission granted: \(granted)")
                guard granted else {return}
                self.getNotificationSettings()
            }
        }
        func getNotificationSettings() {
            notificationcenter.getNotificationSettings { (settings) in
                print("Settings: \(settings)")
            }
        }
        func scheduleNotification(notificationType: String) {
            let content = UNMutableNotificationContent()
            let userAction = "User Action"
            content.title = notificationType
            content.body = "content body"
            content.sound = UNNotificationSound.default
            content.badge = 1
            content.categoryIdentifier = userAction
            guard let path = Bundle.main.path(forResource: "sea", ofType: "png") else {
                return
            }
            let url = URL(fileURLWithPath: path)
            do {
                let attachment = try UNNotificationAttachment(identifier: "pic", url: url, options: nil)
                content.attachments = [attachment]
            } catch  {
                print("can't load picture")
            }
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let id = "Local"
            
            let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
            notificationcenter.add(request) { (error) in
                if let error = error {
                    print(error)
                }
            }
            let snooze = UNNotificationAction(identifier: "Snooze", title: "Snooze", options:[])
            let delete = UNNotificationAction(identifier: "Delete", title: "Delete", options:[.destructive])
            let category = UNNotificationCategory(identifier: userAction, actions: [snooze, delete], intentIdentifiers: [], options: [])
            notificationcenter.setNotificationCategories([category])
        }

        func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHandler([.alert, .sound])
        }
        func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
            if response.notification.request.identifier == "Local" {
                print("handle notification with id: Local ")
            }
            switch response.actionIdentifier {
            case UNNotificationDismissActionIdentifier:
                print("Dismiss")
            case UNNotificationDefaultActionIdentifier:
                print("Default")
            case "Snooze":
                print("Snooze")
                scheduleNotification(notificationType: "Remind")
            case "Delete":
                print("Delete")
            default:
                print("Unknown")
            }
            completionHandler()
        }
        
    }

