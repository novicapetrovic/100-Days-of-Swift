//
//  ViewController.swift
//  Project21
//
//  Created by Novica Petrovic on 16/03/2020.
//  Copyright © 2020 Novica Petrovic. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
    }

    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()

        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("yay!")
            } else {
                print("D'oh!")
            }
        }
    }

    @objc func scheduleLocal(remindLater: Bool) {
        registerCategories()
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()

        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = .default

        var dateComponents = DateComponents()
        var trigger: UNNotificationTrigger

        if remindLater {
            let timeInterval = 86400
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeInterval), repeats: false)
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        } else {
            dateComponents.hour = 10
            dateComponents.minute = 30
//            trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        }

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }

    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self

        let show = UNNotificationAction(identifier: "show", title: "Tell me more...", options: .foreground)
        let remindLater = UNNotificationAction(identifier: "remindLater", title: "Remind me later", options: .destructive)
        let category = UNNotificationCategory(identifier: "alarm", actions: [show, remindLater], intentIdentifiers: [], options: [])

        center.setNotificationCategories([category])

    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo

        if let customData = userInfo["customData"] as? String {
            print("Custom data recieved: \(customData)")

            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                print("Default identifier")
                let alert = UIAlertController(title: "Default identifier", message: "Option 1", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
            case "show":
                print("show more information...")
                let alert = UIAlertController(title: "Show more information", message: "Option 2", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
            case "remindLater":
                scheduleLocal(remindLater: true)
            default:
                break
            }
        }

        completionHandler()
    }
}

