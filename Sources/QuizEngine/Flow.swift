//
//  Flow.swift
//  
//
//  Created by Marcos Barbosa on 14/07/21.
//

import Foundation

protocol Router {
    typealias AnswerCallback = (String) -> Void
    func routerTo(question: String, answerCallback: @escaping AnswerCallback)
    func routerTo(result: [String: String])
}

class Flow {
    
    private let router: Router
    private let questions: [String]
    private var result: [String: String] = [:]
    
    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routerTo(question: firstQuestion, answerCallback: routeNext(from: firstQuestion))
        } else {
            router.routerTo(result: result)
        }
    }
    
    private func routeNext(from question: String) -> Router.AnswerCallback {
        return { [weak self] answer in
            guard let strongSelf = self else { return }
            if let currentQuestionIndex = strongSelf.questions.firstIndex(of: question) {
                strongSelf.result[question] = answer
                
                if currentQuestionIndex+1 < strongSelf.questions.count {
                    let nextQuestion = strongSelf.questions[currentQuestionIndex+1]
                    strongSelf.router.routerTo(question: nextQuestion, answerCallback: strongSelf.routeNext(from: nextQuestion))
                } else {
                    strongSelf.router.routerTo(result: strongSelf.result)
                }
            }
        }
    }
}
