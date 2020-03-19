//
//  QuestionService.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 3/19/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation
import MOLH
import Alamofire
import SwiftyJSON

class QuestionService {
    
    static let instance = QuestionService()
    
    func getQuestions(completion: @escaping (_ error: Error?, _ questions: [Question]?) -> Void){
        Alamofire.request(QUESTIONS_URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(error, nil)
                print(error)
            case .success(let value):
                let json = JSON(value)
                var questions = [Question]()
                if let questionsArr = json.array {
                    for item in questionsArr {
                        guard let item = item.dictionary else {return}
                        let question = Question()
                        question.QuestionId = item["QuestionId"]?.int ?? 0
                        question.QuestionAR = item["QuestionAR"]?.string ?? ""
                        question.QuestionEN = item["QuestionEN"]?.string ?? ""
                        question.AnswerAR = item["AnswerAR"]?.string ?? ""
                        question.AnswerEN = item["AnswerEN"]?.string ?? ""
                        question.Email = item["Email"]?.string ?? ""
                        questions.append(question)
                    }
                }
                completion(nil,questions)
            }
        }
    }
}

