//
//  AlertController.swift
//  Trivia!
//
//  Created by David Boyd on 5/19/21.
//

import UIKit

class AlertController: UIViewController {
    
    static let sharedInstance = AlertController()
    var correctAnswer: String = ""
    
    func presentAlert(answer: String) {
        let success = answer == correctAnswer
        
        let alertController = UIAlertController(title: success ? "Good Job!" : "Wrong Answer.", message: success ? "If you would like to play more, please click continue." : "The corrent answer is \(correctAnswer)", preferredStyle: .alert)
        
        let doneAction = UIAlertAction(title: "Done", style: .cancel)
        let continueAction = UIAlertAction(title: "Continue", style: .default) { (_) in
            //display question
        }
        
        alertController.addAction(doneAction)
        alertController.addAction(continueAction)
        
        present(alertController, animated: true)
    }
    
}//End of class
