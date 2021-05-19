//
//  QuestionViewController.swift
//  Trivia!
//
//  Created by Jin Joo Lee on 5/19/21.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var answerButton: UIButton!
    
    var questions: [Question] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setData()
    }
    
    func setData() {
        QuestionController.fetchQuestions { (result) in
            switch result {
            case .success(let questions):
                self.questions = questions
                
                DispatchQueue.main.async {
                    self.questionLabel.text = questions.first?.question
                    self.categoryLabel.text = questions.first?.category
                    self.difficultyLabel.text = questions.first?.difficulty
                }
            case .failure(let error):
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
    }

    @IBAction func multipleChoiceButtonTapped(_ sender: Any) {
        
    }
}
