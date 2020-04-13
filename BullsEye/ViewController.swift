//
//  ViewController.swift
//  FirstApp
//
//  Created by Lean Caro on 05/03/2020.
//  Copyright © 2020 Leandro Higa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Help/temporal variable
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    // Connect to the slider
    @IBOutlet weak var slider: UISlider!
    
    // Connect to the target label
    @IBOutlet weak var targetLabel: UILabel!
    
    // Connect to the score label
    @IBOutlet weak var scoreLabel: UILabel!
    
    // Connect to the round label
    @IBOutlet weak var roundLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Round the slider value and assign it to the new variable roundedValue
        let roundedValue = slider.value.rounded()
        
        // Assign the new variable to the help variable (currentValue)
        currentValue = Int(roundedValue)
        
        // Calling the function to start a new game
        startNewGame()
        
        // Target normal image
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        // Target highlighted image (when pressed)
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        // Expanding slider image
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        // Slider image to the left
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        // Slider image to the right
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        
    }

    // Connect to HIT ME button
    @IBAction func showAlert() {
        
        // Calculate the points earned (difference between current value vs. target value)
        // abs function return the absolute value 
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        // Create the message/title that will pop-up to the user
        // Bonus: if the difference is 0, give a 100 bonus points
        // Bonus: if the difference is 1, give a 50 bonus points
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        
        // Calculate the score based on the points you earn
        score += points
        
        // Create the message
        let message = "Slilder value: \(currentValue)\nYou scored \(points) points"
        
        // Create UIAlertController
        // Upper body of the notification
        let alert = UIAlertController(title: "\(title)", message: message, preferredStyle: .alert)
        
        // Create UIAlertAction
        // Button (the one that user press)
        // The handler code is executed when the button is tapped
        let action = UIAlertAction(title: "Awesome", style: .default, handler: {
            action in
            self.startNewRound()
        })
        
        // Le Agrego el action al alert creado
        alert.addAction(action)
        
        // Presento la alerta
        present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        
        // Round the slider value and assign it to the new variable roundedValue
        let roundedValue = slider.value.rounded()
        
        // Assign the new variable to the help variable (currentValue)
        currentValue = Int(roundedValue)
    }
 
    // Creating the function to start a new round
    func startNewRound() {
        
        // Increment by 1 the round
        round += 1
        
        // Generating a random number for the target value
        targetValue = Int.random(in: 1...100)
        
        // Put the current value of the slider to 50 (in the middle)
        currentValue = 50
        
        
        slider.value = Float(currentValue)
        
        // Calling the function to update labels
        updateLabels()
    }
    
    // Creating the function to update the target label
    func updateLabels() {
        
        // Cast targetValue to a string
        targetLabel.text = String(targetValue)
        
        // Update score label
        scoreLabel.text = String(score)
        
        // Update round label
        roundLabel.text = String(round)
        
    }
    
    // Button "Start Over" to start a new game
    @IBAction func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }

    
}

