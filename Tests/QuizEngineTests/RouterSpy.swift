//
//  RouterSpy.swift
//  
//
//  Created by Marcos Barbosa on 26/07/21.
//

import Foundation
import QuizEngine

class RouterSpy: Router {
    var routedQuestions: [String] = []
    var routedResult: Result<String, String>? = nil
    var answerCallback: (String) -> Void = { _ in }
    
    func routerTo(question: String, answerCallback: @escaping (String) -> Void) {
        routedQuestions.append(question)
        self.answerCallback = answerCallback
    }
    
    func routerTo(result: Result<String, String>) {
        self.routedResult = result
    }
}
