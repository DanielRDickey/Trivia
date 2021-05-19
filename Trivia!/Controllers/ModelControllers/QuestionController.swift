//
//  File.swift
//  Trivia!
//
//  Created by Daniel Dickey on 5/19/21.
//

import Foundation

class QuestionController {
    
    // MARK: - Call
    
    //Final URL = https://opentdb.com/api.php?amount=10&type=multiple
    
    static func fetchQuestions(completion: @escaping (Result<[Question], NetworkError>) -> Void)  {
        let baseURL = "https://opentdb.com/api.php"
        let amountQuery = URLQueryItem(name: "amount", value: "10")
        let typeQuery = URLQueryItem(name: "type", value: "multiple")
        
        var components = URLComponents(string: baseURL)
        components?.queryItems = [amountQuery, typeQuery]
        
        guard let finalURL = components?.url else {return completion(.failure(.invalidURL))}
        print(finalURL)
        
        let request = URLRequest(url: finalURL)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("STATUS CODE: \(response.statusCode)")
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            do {
                let topLevelObject = try JSONDecoder().decode(Questions.self, from: data)
                let questions = topLevelObject.questionList
                
                completion(.success(questions))
                
            } catch {
                return completion(.failure(.unableToDecode))
            }
            
        }.resume()
        
    }
    
   static func convertSpecialCharacters(input: String) -> String {
        
            var newString = input
        
            let characterDictionary = [
                "&amp;" : "&",
                "&lt;" : "<",
                "&gt;" : ">",
                "&quot;" : "\"",
                "&apos;" : "'",
                "&#039;" : "'"
            ]
            for (escapedCharacter, unescapedCharacter) in characterDictionary {
                newString = newString.replacingOccurrences(of: escapedCharacter, with: unescapedCharacter, options: NSString.CompareOptions.literal, range: nil)
            }
            return newString
    }
    
}//End of class
