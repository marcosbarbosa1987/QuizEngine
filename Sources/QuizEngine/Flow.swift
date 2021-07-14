//
//  Flow.swift
//  
//
//  Created by Marcos Barbosa on 14/07/21.
//

import Foundation

protocol Router {
    func routerTo(question: String)
}

class Flow {
    
    let router: Router
    let questions: [String]
    
    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        if !questions.isEmpty {
            router.routerTo(question: "")
        }
    }
}
