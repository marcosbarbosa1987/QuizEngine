//
//  Flow.swift
//  
//
//  Created by Marcos Barbosa on 14/07/21.
//

import Foundation

class Flow <Question: Hashable, Answer, R: Router> where R.Question == Question, R.Answer == Answer {
    
    private let router: R
    private let questions: [Question]
    private var answers: [Question: Answer] = [:]
    private var scoring: ([Question: Answer]) -> Int
    
    init(questions: [Question], router: R, scoring: @escaping([Question: Answer]) -> Int) {
        self.questions = questions
        self.router = router
        self.scoring = scoring
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routerTo(question: firstQuestion, answerCallback: nextCallback(from: firstQuestion))
        } else {
            router.routerTo(result: result())
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
            answers[question] = answer
            let nextQuestionIndex = currentQuestionIndex+1
            
            if  nextQuestionIndex < questions.count {
                let nextQuestion = questions[nextQuestionIndex]
                router.routerTo(question: nextQuestion, answerCallback: nextCallback(from: nextQuestion))
            } else {
                router.routerTo(result: result())
            }
        }
    }
    
    private func result() -> Result<Question, Answer> {
        return Result(answers: answers, score: scoring(answers))
    }
}
