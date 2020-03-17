//
//  ViewController.swift
//  Project2
//
//  Created by Novica Petrovic on 27/02/2020.
//  Copyright © 2020 Novica Petrovic. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!

    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsAsked = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        registerLocal()
        

        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]

        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1

        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor

        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        questionsAsked += 1
        if questionsAsked == 11 {
            let ac = UIAlertController(title: "That's the end of the game", message: "Your final score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "End Game", style: .default, handler: nil))
            present(ac, animated: true)
            title = "Final Score: \(score)"

            button1.isEnabled = false
            button2.isEnabled = false
            button3.isEnabled = false
        } else {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)

            button1.setImage(UIImage(named: countries[0]), for: .normal)
            button2.setImage(UIImage(named: countries[1]), for: .normal)
            button3.setImage(UIImage(named: countries[2]), for: .normal)

            title = "\(countries[correctAnswer].uppercased())" + " - Current Score: \(score)"
        }
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String

        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong, the correct answer was: \(countries[correctAnswer])"
            score -= 1
        }

        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)

        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))

        present(ac, animated: true)
    }

}

extension ViewController: UNUserNotificationCenterDelegate{
    @objc func notificationDecider() {
        let current = UNUserNotificationCenter.current()

        current.getNotificationSettings(completionHandler: { (settings) in
            if settings.authorizationStatus == .notDetermined {
                // Notification permission has not been asked yet, go for it!

                self.registerLocal()

            } else if settings.authorizationStatus == .denied {
                // Notification permission was previously denied, go to settings & privacy to re-enable

                let alert = UIAlertController(title: "Permission Required", message: "Go to settings & privacy to enable push notifications for Project21", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)

            } else if settings.authorizationStatus == .authorized {
                // Notification permission was already granted

                self.scheduleLocal()

            }
        })

    }

    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self

        let show = UNNotificationAction(identifier: "show", title: "Tell me more...", options: .foreground)
        let remindLater = UNNotificationAction(identifier: "remindLater", title: "Remind me later")
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

    @objc func registerLocal() {
        let current = UNUserNotificationCenter.current()

        current.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("yay!")
            } else {
                print("D'oh!")
            }
        }
    }

    func scheduleLocal(remindLater: Bool = false) {
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
    //            trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeInterval), repeats: false)
                trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)   // for testing
            } else {
                dateComponents.hour = 10
                dateComponents.minute = 30
    //            trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)    // for testing
            }

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
}
