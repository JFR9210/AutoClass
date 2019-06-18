//
//  FormSection.swift
//  AutoClass
//
//  Created by Jonathan Fajardo Roa on 5/21/19.
//  Copyright © 2019 JFR. All rights reserved.
//

import Foundation

class FormSection: Codable {
    
    var title : String!
    var items : [Form]!
    
    init(title: String, items: [Form]) {
        self.title = title
        self.items = items
    }
    
}
