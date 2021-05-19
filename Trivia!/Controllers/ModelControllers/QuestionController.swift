//
//  File.swift
//  Trivia!
//
//  Created by Daniel Dickey on 5/19/21.
//

import Foundation

class QuestionController {
    
    // MARK: - Properties
    
    let shared = QuestionController()
//    var questions: [Questions] = []
    
    // MARK: - Call
    
    //Final URL = https://opentdb.com/api.php?amount=10&type=multiple
    
    static func fetchQuestions(completion: @escaping (Result<Data, NetworkError>) -> Void)  {
        let baseURL = "https://opentdb.com/api.php"
        let amountQuery = URLQueryItem(name: "amount", value: "10")
        let typeQuery = URLQueryItem(name: "type", value: "multiple")
        
        var components = URLComponents(string: baseURL)
        components?.queryItems = [amountQuery, typeQuery]
        
        guard let finalURL = components?.url else {return completion(.failure(.invalidURL))}
        print(finalURL)
        
        var request = URLRequest(url: finalURL)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            do {
                let questions = try JSONDecoder()
            } catch {
                return completion(.failure(.unableToDecode))
            }
            
        }.resume()
        
        
    }
    
}//End of class
