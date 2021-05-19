//
//  Question.swift
//  Trivia!
//
//  Created by Jin Joo Lee on 5/19/21.
//

import Foundation

struct Questions: Codable {
    var questionList: [Question]
    
    enum CodingKeys: String, CodingKey {
        case questionList = "results"
    }
}

struct Question: Codable {
    var category: String
    var difficulty: String
    var question: String
    var correct_answer: String
    var incorrect_answers: [String]
}
