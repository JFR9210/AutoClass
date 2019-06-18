//
//  brand.swift
//  AutoClass
//
//  Created by Jonathan Fajardo Roa on 5/8/19.
//  Copyright © 2019 JFR. All rights reserved.
//

import Foundation

class Brand: Codable {
    
    var id : String!
    var name : String!
    var created_date : String!
    var created_time : String!
    var state : String!
    
    init(id: String, name: String, created_date: String, created_time: String, state: String) {
        self.id = id
        self.name = name
        self.created_date = created_date
        self.created_time = created_time
        self.state = state
    }
    
    func initWithJSON(jsonData : Data) -> Any{
        
        do {
            // Decode data to object
            let jsonDecoder = JSONDecoder()
            let brand = try jsonDecoder.decode(Brand.self, from: jsonData)
            return brand
        }
        catch {
            
        }
        
        return false
        
    }
    
}
