//
//  ViewController.swift
//  Project2
//
//  Created by Novica Petrovic on 27/02/2020.
//  Copyright © 2020 Novica Petrovic. All rights reserved.
//

import UIKit

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

