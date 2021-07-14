//
//  Flow.swift
//  
//
//  Created by Marcos Barbosa on 14/07/21.
//

import Foundation

protocol Router {
    func routerTo(question: String, answerCallback: @escaping(String) -> Void)
}

class Flow {
    
    let router: Router
    let questions: [String]
    
    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routerTo(question: firstQuestion) { [weak self] _ in
                guard let strongSelf = self else { return }
                let firstQuestionIndex = strongSelf.questions.firstIndex(of: firstQuestion)!
                let nextQuestion = strongSelf.questions[firstQuestionIndex+1]
                strongSelf.router.routerTo(question: nextQuestion) { _ in }
            }
        }
    }
}
