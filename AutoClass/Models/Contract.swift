//
//  Contract.swift
//  AutoClass
//
//  Created by Jonathan Fajardo Roa on 6/6/19.
//  Copyright © 2019 JFR. All rights reserved.
//

import Foundation

class Contract: Decodable {
    
    var id : String!
    var client_id : String!
    var car_id : String!
    var precio_contrato : String!
    var precio_vehiculo : String!
    var firma1 : String!
    var firma1Datos : Data!
    var firma1Downloading: String!
    var firma2 : String!
    var firma2Datos : Data!
    var firma2Downloading: String!
    var number : String!
    var created_date : String!
    var created_time : String!
    var state : String!
    var client : Client!
    var car : Car!
    
    init (id: String, client_id: String, car_id: String, precio_contrato: String, precio_vehiculo: String, firma1: String, firma2: String, number: String, created_date: String, created_time: String, state: String) {
        self.id = id
        self.client_id = client_id
        self.car_id = car_id
        self.precio_contrato = precio_contrato
        self.precio_vehiculo = precio_vehiculo
        self.firma1 = firma1
        self.firma2 = firma2
        self.number = number
        self.created_date = created_date
        self.created_time = created_time
        self.state = state
    }
    
    func initWithJSON(jsonData : Data) -> Contract{
        
        do {
            // Decode data to object
            let jsonDecoder = JSONDecoder()
            let contract = try jsonDecoder.decode(Contract.self, from: jsonData)
            return contract
        }
        catch {
            print("catch initWithJSON")
        }
        
        return self
        
    }
    
    func toDictionary(contract: Contract) -> [String: Any] {
        
        var json : [String : Any]!
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(contract)
            let jsonString = String(data: jsonData, encoding: .utf8)
            print("JSON String : " + jsonString!)
            
            do {
                
                json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                
                return json
                
            } catch {
                print("catch request")
            }
            
        }
        catch {
            
        }
        
        return json
    }
    
}

extension Contract : Encodable {
    
    func setValueField(contract : Contract, field : String, answer : String) -> Contract{
        
        var contractNew = contract
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(contract)
            let jsonString = String(data: jsonData, encoding: .utf8)
            print("JSON String : " + jsonString!)
            
            do {
                
                var json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]
                
                json[field] = answer
                
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                    
                    do {
                        // Decode data to object
                        let jsonDecoder = JSONDecoder()
                        contractNew = try jsonDecoder.decode(Contract.self, from: jsonData)
                    } catch {
                        print("catch initWithJSON \(error)")
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
                
            } catch {
                print("catch request")
            }
            
            
        }
        catch {
            
        }
        
        return contractNew
    }
    
}

