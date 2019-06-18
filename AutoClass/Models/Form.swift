//
//  Form.swift
//  AutoClass
//
//  Created by Jonathan Fajardo Roa on 5/21/19.
//  Copyright © 2019 JFR. All rights reserved.
//

import Foundation

class Form : Codable {
    
    var question: String!
    var answer: String!
    var type: String!
    var typeKeyboard: String!
    var titleQuestion1: String!
    var titleQuestion2: String!
    var section: String!
    var field: String!
    
    init(question: String, answer: String, type: String, typeKeyboard: String, titleQuestion1: String, titleQuestion2: String, section: String, field: String) {
        self.question = question
        self.answer = answer
        self.type = type
        self.typeKeyboard = typeKeyboard
        self.titleQuestion1 = titleQuestion1
        self.titleQuestion2 = titleQuestion2
        self.section = section
        self.field = field
    }
    
    
    
}
