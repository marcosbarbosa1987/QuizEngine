//
//  File.swift
//  
//
//  Created by Marcos Barbosa on 26/07/21.
//

import Foundation

public protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer
    
    func routerTo(question: Question, answerCallback: @escaping (Answer) -> Void)
    func routerTo(result: Result<Question, Answer>)
}
