//
//  QuestionViewController.swift
//  Trivia!
//
//  Created by Jin Joo Lee on 5/19/21.
//

import UIKit

class QuestionViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
    }
    
    // MARK: - Properties
    
    var questions: [Question] = []
    var questionNumber = 0
    var scores = 0
    
    // MARK: - Functions
    
    func setNextQuestion() {
        if questionNumber < 9 {
            questionNumber += 1
            updateProgressBar()
        } else {
            endGame()
            return
        }
        
        let fixedQuestion = QuestionController.convertSpecialCharacters(input: questions[questionNumber].question)
        questionLabel.text = fixedQuestion
        categoryLabel.text = questions[questionNumber].category
        difficultyLabel.text = "Difficulty: \(questions[questionNumber].difficulty)"
    
        setAnswers()
    }
    
    func updateProgressBar() {
        progressBar.setProgress(Float(questionNumber + 1) / Float(10), animated: true)
    }
    
    func setAnswers() {
        
        var answersArray = questions[questionNumber].incorrect_answers
        answersArray.append(questions[questionNumber].correct_answer)
        answersArray.shuffle()
        let fixedAnswers = answersArray.map({ QuestionController.convertSpecialCharacters(input: $0) } )
        
        answerButton1.setTitle(fixedAnswers[0], for: .normal)
        answerButton2.setTitle(fixedAnswers[1], for: .normal)
        answerButton3.setTitle(fixedAnswers[2], for: .normal)
        answerButton4.setTitle(fixedAnswers[3], for: .normal)
        
        updateButtonViews()
    }
    
    func updateButtonViews() {
        answerButton1.layer.borderWidth = 5.0
        answerButton1.layer.borderColor = UIColor.black.cgColor
        answerButton1.backgroundColor = UIColor.black
        answerButton1.tintColor = UIColor.white
        
        answerButton2.layer.borderWidth = 5.0
        answerButton2.layer.borderColor = UIColor.black.cgColor
        answerButton2.backgroundColor = UIColor.black
        answerButton2.tintColor = UIColor.white
        
        answerButton3.layer.borderWidth = 5.0
        answerButton3.layer.borderColor = UIColor.black.cgColor
        answerButton3.backgroundColor = UIColor.black
        answerButton3.tintColor = UIColor.white
        
        answerButton4.layer.borderWidth = 5.0
        answerButton4.layer.borderColor = UIColor.black.cgColor
        answerButton4.backgroundColor = UIColor.black
        answerButton4.tintColor = UIColor.white
    }
    
    func endGame() {
        self.presentEndGameAlert()
    }
    
    func setData() {
        QuestionController.fetchQuestions { [weak self] (result) in
            switch result {
            case .success(let questions):
                self?.questions = questions
                
                DispatchQueue.main.async {
                    let fixedQuestion = QuestionController.convertSpecialCharacters(input: questions[self?.questionNumber ?? 0].question)
                    self?.questionLabel.text = fixedQuestion
                    self?.categoryLabel.text = questions[0].category
                    self?.difficultyLabel.text = questions[0].difficulty
                    self?.setAnswers()
                }
                
            case .failure(let error):
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
    }
    
    
    func presentAlert(answer: String) {
        
        let correctAnswer = questions[questionNumber].correct_answer
        let success = answer == correctAnswer
        if success == true {
            scores += 1
        }
        
        let fixedAnswer = QuestionController.convertSpecialCharacters(input: correctAnswer)
        
        let alertController = UIAlertController(title: success ? "Good Job!" : "Wrong Answer.", message: success ? "If you would like to play more, please click continue." : "The corrent answer is \(fixedAnswer)", preferredStyle: .alert)

        
        let doneAction = UIAlertAction(title: "Done", style: .cancel)
        let continueAction = UIAlertAction(title: "Continue", style: .default) { [weak self] (_) in
            self?.setNextQuestion()
        }
        
        alertController.addAction(doneAction)
        alertController.addAction(continueAction)
        
        present(alertController, animated: true)
    }
    
    func presentEndGameAlert() {
        
        let alertController = UIAlertController(title: "You Finished the Game!", message: "You scored \(scores)/10.", preferredStyle: .alert)
        
        let doneAction = UIAlertAction(title: "Done", style: .cancel)
        let newGameAction = UIAlertAction(title: "Start A New Game", style: .default) { (_) in

            self.questionNumber = 0
            self.setData()
            self.scores = 0
            self.updateProgressBar()

        }
        
        alertController.addAction(doneAction)
        alertController.addAction(newGameAction)
        
        present(alertController, animated: true)
    }

    // MARK: - Actions
    
    @IBAction func multipleChoiceButtonTapped(_ sender: Any) {
        guard let answer = (sender as AnyObject).titleLabel?.text else {return}
        presentAlert(answer: answer)

    }

}//End of class
