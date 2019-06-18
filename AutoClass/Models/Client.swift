//
//  client.swift
//  AutoClass
//
//  Created by Jonathan Fajardo Roa on 5/8/19.
//  Copyright © 2019 JFR. All rights reserved.
//

import Foundation

class Client : Decodable {
    
    var id : String!
    var name : String!
    var address : String!
    var phone : String!
    var rut : String!
    var mail : String!
    var created_date : String!
    var created_time : String!
    var state : String!
    
    init (id: String, name: String, address: String, phone: String, rut: String, mail: String, created_date: String, created_time: String, state: String) {
        self.id = id
        self.name = name
        self.address = address
        self.phone = phone
        self.rut = rut
        self.mail = mail
        self.created_date = created_date
        self.created_time = created_time
        self.state = state
    }
    
    func initWithJSON(jsonData : Data) -> Client{
        
        do {
            // Decode data to object
            let jsonDecoder = JSONDecoder()
            let client = try jsonDecoder.decode(Client.self, from: jsonData)
            return client
        }
        catch {
            print("catch initWithJSON")
        }
        
        return self
        
    }
    
}

extension Client : Encodable{
    
}
