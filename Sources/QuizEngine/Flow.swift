//
//  Flow.swift
//  
//
//  Created by Marcos Barbosa on 14/07/21.
//

import Foundation

protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer
    
    func routerTo(question: Question, answerCallback: @escaping (Answer) -> Void)
    func routerTo(result: [Question: Answer])
}

class Flow <Question: Hashable, Answer, R: Router> where R.Question == Question, R.Answer == Answer {
    
    private let router: R
    private let questions: [Question]
    private var result: [Question: Answer] = [:]
    
    init(questions: [Question], router: R) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routerTo(question: firstQuestion, answerCallback: nextCallback(from: firstQuestion))
        } else {
            router.routerTo(result: result)
        }
    }
    
    private func nextCallback(from question: Question) -> (Answer) -> Void {
        return { [weak self] answer in
            guard let strongSelf = self else { return }
            strongSelf.routeNext(question, answer)
        }
    }
    
    private func routeNext(_ question: Question, _ answer: Answer) {
        if let currentQuestionIndex = questions.firstIndex(of: question) {
            result[question] = answer
            let nextQuestionIndex = currentQuestionIndex+1
            
            if  nextQuestionIndex < questions.count {
                let nextQuestion = questions[nextQuestionIndex]
                router.routerTo(question: nextQuestion, answerCallback: nextCallback(from: nextQuestion))
            } else {
                router.routerTo(result: result)
            }
        }
    }
}
