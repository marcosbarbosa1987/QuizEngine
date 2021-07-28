//
//  File.swift
//  
//
//  Created by Marcos Barbosa on 26/07/21.
//

import Foundation

public struct Result<Question: Hashable, Answer> {
    public let answers: [Question: Answer]
    public let score: Int
}
