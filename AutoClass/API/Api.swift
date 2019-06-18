//
//  api.swift
//  AutoClass
//
//  Created by Jonathan Fajardo Roa on 5/8/19.
//  Copyright © 2019 JFR. All rights reserved.
//

import Foundation
import UIKit

class CarService {
    
    static func deleteCar(VC: UIViewController, jsonParams: [String: Any], callBack:@escaping (String) -> Void){
        
        print("deleteCar")
        
        let url = URL(string:"\(Utils.URL_SERVER)car_delete.php")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let parameter:String = "token_autoclass=aUu0u0t9o0c3b78deu3m0p6hcudb2b31e439Cbcc1be8acb&id=\(jsonParams["id"] as! String)"
        let parameterData:Data = parameter.data(using: String.Encoding.utf8)!
        request.httpBody = parameterData
        
        let task = URLSession.shared.dataTask(with: request){data,response,error in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Response \(httpResponse.statusCode)")
                
                if httpResponse.statusCode == 200 {
                    
                    if error == nil {
                        
                        DispatchQueue.main.async(execute: {
                            print("async")
                            
                            do {
                                let dataString = NSString(data:data!, encoding: String.Encoding.utf8.rawValue)
                                print("dataString: \(dataString!)")
                                
                                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]
                                
                                let request = json["request"] as! String
                                if request == "ok" {
                                    
                                    callBack("ok")
                                    
                                } else {
                                    Utils.showAlert(message: json["message"] as! String, VC: VC)
                                }
                                
                            } catch {
                                print("catch request")
                            }
                            
                        })
                        
                    } else {
                        Utils.showAlert(message: Utils.TRY_AGAIN_TEXT, VC: VC)
                    }
                    
                } else {
                    Utils.showAlert(message: Utils.TRY_AGAIN_TEXT, VC: VC)
                }
                
            }
            
        }
        task.resume()
        
    }
    
    static func editCarImage(VC: UIViewController, jsonParams: [String: Any], callBack:@escaping (Car) -> Void){
        
        print("editCarImage")
        
        var car: Car!
        
        let url = URL(string:"\(Utils.URL_SERVER)car_edit.php")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        let boundary = "---------------------------14737809831466499882746641449"
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body: Data = Data()
      
        var linea:String = ""
        for (key, value) in jsonParams {
            if key != "foto1" && key != "foto2" && key != "foto3" && key != "foto4" && key != "foto1Datos" && key != "foto2Datos" && key != "foto3Datos" && key != "foto4Datos" && key != "foto1Downloading" && key != "foto2Downloading" && key != "foto3Downloading" && key != "foto4Downloading" && key != "brand" {
                linea = "--\(boundary)\r\n"
                body.append(linea.data(using: String.Encoding.utf8)!)
                linea = "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n"
                body.append(linea.data(using: String.Encoding.utf8)!)
                linea = value as! String
                //print("VALOR \(linea)")
                body.append(linea.data(using: String.Encoding.utf8)!)
                linea = "\r\n"
                body.append(linea.data(using: String.Encoding.utf8)!)
            }
        }
        
        linea = "--\(boundary)\r\n"
        body.append(linea.data(using: String.Encoding.utf8)!)
        linea = "Content-Disposition: form-data; name=\"token_autoclass\"\r\n\r\n"
        body.append(linea.data(using: String.Encoding.utf8)!)
        linea = "aUu0u0t9o0c3b78deu3m0p6hcudb2b31e439Cbcc1be8acb"
        //print("VALOR \(linea)")
        body.append(linea.data(using: String.Encoding.utf8)!)
        linea = "\r\n"
        body.append(linea.data(using: String.Encoding.utf8)!)
        
        if jsonParams["foto1Datos"] != nil {
            linea = "\r\n--\(boundary)\r\n"
            body.append(linea.data(using: String.Encoding.utf8)!)
            linea = "Content-Disposition: form-data; name=\"foto1\"\r\n\r\n"
            body.append(linea.data(using: String.Encoding.utf8)!)
            linea = "foto1"
            body.append(linea.data(using: String.Encoding.utf8)!)
            linea = "\r\n--\(boundary)\r\n"
            body.append(linea.data(using: String.Encoding.utf8)!)
            linea = "Content-Disposition: form-data; name=\"foto1\"; filename=\"foto1.jpg\"\r\n"
            body.append(linea.data(using: String.Encoding.utf8)!)
            linea = "Content-Type: application/octet-stream\r\n\r\n"
            body.append(linea.data(using: String.Encoding.utf8)!)
            body.append(jsonParams["foto1Datos"] as! Data)
        }
        
        if jsonParams["foto2Datos"] != nil {
            linea = "\r\n--\(boundary)\r\n"
            body.append(linea.data(using: String.Encoding.utf8)!)
            linea = "Content-Disposition: form-data; name=\"foto2\"\r\n\r\n"
            body.append(linea.data(using: String.Encoding.utf8)!)
            linea = "foto2"
            body.append(linea.data(using: String.Encoding.utf8)!)
            linea = "\r\n--\(boundary)\r\n"
            body.append(linea.data(using: String.Encoding.utf8)!)
            linea = "Content-Disposition: form-data; name=\"foto2\"; filename=\"foto2.jpg\"\r\n"
            body.append(linea.data(using: String.Encoding.utf8)!)
            linea = "Content-Type: application/octet-stream\r\n\r\n"
            body.append(linea.data(using: String.Encoding.utf8)!)
            body.append(jsonParams["foto2Datos"] as! Data)
        }
        
        if jsonParams["foto3Datos"] != nil {
            linea = "\r\n--\(boundary)\r\n"
            body.append(linea.data(using: String.Encoding.utf8)!)
            linea = "Content-Disposition: form-data; name=\"foto3\"\r\n\r\n"
            body.append(linea.data(using: String.Encoding.utf8)!)
            linea = "foto3"
            body.append(linea.data(using: String.Encoding.utf8)!)
            linea = "\r\n--\(boundary)\r\n"
            body.append(linea.data(using: String.Encoding.utf8)!)
            linea = "Content-Disposition: form-data; name=\"foto3\"; filename=\"foto3.jpg\"\r\n"
            body.append(linea.data(using: String.Encoding.utf8)!)
            linea = "Content-Type: application/octet-stream\r\n\r\n"
            body.append(linea.data(using: String.Encoding.utf8)!)
            body.append(jsonParams["foto3Datos"] as! Data)
        }
        
        if jsonParams["foto4Datos"] != nil {
            linea = "\r\n--\(boundary)\r\n"
            body.append(linea.data(using: String.Encoding.utf8)!)
            linea = "Content-Disposition: form-data; name=\"foto4\"\r\n\r\n"
            body.append(linea.data(using: String.Encoding.utf8)!)
            linea = "foto4"
            body.append(linea.data(using: String.Encoding.utf8)!)
            linea = "\r\n--\(boundary)\r\n"
            body.append(linea.data(using: String.Encoding.utf8)!)
            linea = "Content-Disposition: form-data; name=\"foto4\"; filename=\"foto4.jpg\"\r\n"
            body.append(linea.data(using: String.Encoding.utf8)!)
            linea = "Content-Type: application/octet-stream\r\n\r\n"
            body.append(linea.data(using: String.Encoding.utf8)!)
            body.append(jsonParams["foto4Datos"] as! Data)
        }
        
        
        linea = "\r\n--\(boundary)--\r\n"
        body.append(linea.data(using: String.Encoding.utf8)!)
        
        request.httpBody = body
        
        let task = URLSession.shared.uploadTask(with: request, from: body) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Response \(httpResponse.statusCode)")
                
                if httpResponse.statusCode == 200 {
                    
                    if error == nil {
                        
                        DispatchQueue.main.async(execute: {
                            print("async")
                            
                            do {
                                let dataString = NSString(data:data!, encoding: String.Encoding.utf8.rawValue)
                                print("dataString: \(dataString!)")
                                
                                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]
                                
                                let request = json["request"] as! String
                                if request == "ok" {
                                    
                                    let item = json["car"] as! [String: Any]
                                    do {
                                        let jsonData = try JSONSerialization.data(withJSONObject: item, options: .prettyPrinted)
                                        
                                        do {
                                            // Decode data to object
                                            let jsonDecoder = JSONDecoder()
                                            car = try jsonDecoder.decode(Car.self, from: jsonData)
                                        } catch {
                                            print("catch initWithJSON \(error)")
                                        }
                                        
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                    
                                    callBack(car)
                                    
                                } else {
                                    Utils.showAlert(message: json["message"] as! String, VC: VC)
                                }
                                
                            } catch {
                                print("catch request")
                            }
                            
                        })
                        
                    } else {
                        Utils.showAlert(message: Utils.TRY_AGAIN_TEXT, VC: VC)
                    }
                    
                } else {
                    Utils.showAlert(message: Utils.TRY_AGAIN_TEXT, VC: VC)
                }
                
            }
            
        }
        
        task.resume()
        
    }
    
    static func editCar(VC: UIViewController, jsonParams: [String: Any], callBack:@escaping (Car) -> Void){
        
        print("editCar")
        
        var car: Car!
        
        let url = URL(string:"\(Utils.URL_SERVER)car_edit.php")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        var parameter:String = "token_autoclass=aUu0u0t9o0c3b78deu3m0p6hcudb2b31e439Cbcc1be8acb"
        for (key, value) in jsonParams {
            if key != "brand" {
                parameter = "\(parameter)&\(key)=\(value as! String)"
            }
        }
        
        let parameterData:Data = parameter.data(using: String.Encoding.utf8)!
        request.httpBody = parameterData
        
        let task = URLSession.shared.dataTask(with: request){data,response,error in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Response \(httpResponse.statusCode)")
                
                if httpResponse.statusCode == 200 {
                    
                    if error == nil {
                        
                        DispatchQueue.main.async(execute: {
                            print("async")
                            
                            do {
                                let dataString = NSString(data:data!, encoding: String.Encoding.utf8.rawValue)
                                print("dataString: \(dataString!)")
                                
                                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]
                                
                                let request = json["request"] as! String
                                if request == "ok" {
                                    
                                    let item = json["car"] as! [String: Any]
                                    do {
                                        let jsonData = try JSONSerialization.data(withJSONObject: item, options: .prettyPrinted)
                                        
                                        do {
                                            // Decode data to object
                                            let jsonDecoder = JSONDecoder()
                                            car = try jsonDecoder.decode(Car.self, from: jsonData)
                                        } catch {
                                            print("catch initWithJSON \(error)")
                                        }
                                        
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                    
                                    callBack(car)
                                    
                                } else {
                                    Utils.showAlert(message: json["message"] as! String, VC: VC)
                                }
                                
                            } catch {
                                print("catch request")
                            }
                            
                        })
                        
                    } else {
                        Utils.showAlert(message: Utils.TRY_AGAIN_TEXT, VC: VC)
                    }
                    
                } else {
                    Utils.showAlert(message: Utils.TRY_AGAIN_TEXT, VC: VC)
                }
                
            }
            
        }
        task.resume()
        
    }
    
    static func addCar(VC: UIViewController, jsonParams: [String: Any], callBack:@escaping (Car) -> Void){
        
        print("addCar")
        
        var car: Car!
        
        let url = URL(string:"\(Utils.URL_SERVER)car_add.php")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let parameter:String = "token_autoclass=aUu0u0t9o0c3b78deu3m0p6hcudb2b31e439Cbcc1be8acb&patent=\(jsonParams["patent"] as! String)&brand_id=\(jsonParams["brand_id"] as! String)&model=\(jsonParams["model"] as! String)&version=\(jsonParams["version"] as! String)&km=\(jsonParams["km"] as! String)&year=\(jsonParams["year"] as! String)&color=\(jsonParams["color"] as! String)"
        let parameterData:Data = parameter.data(using: String.Encoding.utf8)!
        request.httpBody = parameterData
        
        let task = URLSession.shared.dataTask(with: request){data,response,error in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Response \(httpResponse.statusCode)")
                
                if httpResponse.statusCode == 200 {
                    
                    if error == nil {
                        
                        DispatchQueue.main.async(execute: {
                            print("async")
                            
                            do {
                                let dataString = NSString(data:data!, encoding: String.Encoding.utf8.rawValue)
                                print("dataString: \(dataString!)")
                                
                                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]
                                
                                let request = json["request"] as! String
                                if request == "ok" {
                                    
                                    let item = json["car"] as! [String: Any]
                                    do {
                                        let jsonData = try JSONSerialization.data(withJSONObject: item, options: .prettyPrinted)
                                        
                                        do {
                                            // Decode data to object
                                            let jsonDecoder = JSONDecoder()
                                            car = try jsonDecoder.decode(Car.self, from: jsonData)
                                        } catch {
                                            print("catch initWithJSON \(error)")
                                        }
                                        
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                    
                                    callBack(car)
                                    
                                } else {
                                    Utils.showAlert(message: json["message"] as! String, VC: VC)
                                }
                                
                            } catch {
                                print("catch request")
                            }
                            
                        })
                        
                    } else {
                        Utils.showAlert(message: Utils.TRY_AGAIN_TEXT, VC: VC)
                    }
                    
                } else {
                    Utils.showAlert(message: Utils.TRY_AGAIN_TEXT, VC: VC)
                }
                
            }
            
        }
        task.resume()
        
    }
    
    static func getCars(VC: UIViewController, callBack:@escaping ([Car]) -> Void){
        
        print("getCars")
        
        var listCars: [Car] = []
        
        let url = URL(string:"\(Utils.URL_SERVER)cars.php")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let parameter:String = "token_autoclass=aUu0u0t9o0c3b78deu3m0p6hcudb2b31e439Cbcc1be8acb"
        let parameterData:Data = parameter.data(using: String.Encoding.utf8)!
        request.httpBody = parameterData
        
        let task = URLSession.shared.dataTask(with: request){data,response,error in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Response \(httpResponse.statusCode)")
                
                if httpResponse.statusCode == 200 {
                    
                    if error == nil {
                        
                        DispatchQueue.main.async(execute: {
                            print("async")
                            
                            do {
                                let dataString = NSString(data:data!, encoding: String.Encoding.utf8.rawValue)
                                print("dataString: \(dataString!)")
                                
                                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]
                                
                                let request = json["request"] as! String
                                if request == "ok" {
                                    
                                    let items = json["list"] as! [[String: Any]]
                                    for item in items {
                                        do {
                                            let jsonData = try JSONSerialization.data(withJSONObject: item, options: .prettyPrinted)
                                            
                                            do {
                                                // Decode data to object
                                                let jsonDecoder = JSONDecoder()
                                                let car = try jsonDecoder.decode(Car.self, from: jsonData)
                                                
                                                let JSONBrand = item["brand"] as! [String: Any]
                                                let jsonDataBrand = try JSONSerialization.data(withJSONObject: JSONBrand, options: .prettyPrinted)
                                                let brand = try jsonDecoder.decode(Brand.self, from: jsonDataBrand)
                                                car.brand = brand
                                                
                                                listCars.append(car)
                                            } catch {
                                                print("catch initWithJSON \(error)")
                                            }
                                            
                                        } catch {
                                            print(error.localizedDescription)
                                        }
                                    }
                                    
                                    callBack(listCars)
                                    
                                } else {
                                    Utils.showAlert(message: json["message"] as! String, VC: VC)
                                }
                                
                            } catch {
                                print("catch request")
                            }
                            
                        })
                        
                    } else {
                        Utils.showAlert(message: Utils.TRY_AGAIN_TEXT, VC: VC)
                    }
                    
                } else {
                    Utils.showAlert(message: Utils.TRY_AGAIN_TEXT, VC: VC)
                }
                
            }
            
        }
        task.resume()
        
    }
    
}

class ClientService {
    
    static func deleteClient(VC: UIViewController, jsonParams: [String: Any], callBack:@escaping (String) -> Void){
        
        print("deleteClient")
        
        let url = URL(string:"\(Utils.URL_SERVER)client_delete.php")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let parameter:String = "token_autoclass=aUu0u0t9o0c3b78deu3m0p6hcudb2b31e439Cbcc1be8acb&rut=\(jsonParams["rut"] as! String)"
        let parameterData:Data = parameter.data(using: String.Encoding.utf8)!
        request.httpBody = parameterData
        
        let task = URLSession.shared.dataTask(with: request){data,response,error in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Response \(httpResponse.statusCode)")
                
                if httpResponse.statusCode == 200 {
                    
                    if error == nil {
                        
                        DispatchQueue.main.async(execute: {
                            print("async")
                            
                            do {
                                let dataString = NSString(data:data!, encoding: String.Encoding.utf8.rawValue)
                                print("dataString: \(dataString!)")
                                
                                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]
                                
                                let request = json["request"] as! String
                                if request == "ok" {
                                    
                                    callBack("ok")
                                    
                                } else {
                                    Utils.showAlert(message: json["message"] as! String, VC: VC)
                                }
                                
                            } catch {
                                print("catch request")
                            }
                            
                        })
                        
                    } else {
                        Utils.showAlert(message: Utils.TRY_AGAIN_TEXT, VC: VC)
                    }
                    
                } else {
                    Utils.showAlert(message: Utils.TRY_AGAIN_TEXT, VC: VC)
                }
                
            }
            
        }
        task.resume()
        
    }
    
    static func editClient(VC: UIViewController, jsonParams: [String: Any], callBack:@escaping (Client) -> Void){
        
        print("editClient")
        
        var client: Client!
        
        let url = URL(string:"\(Utils.URL_SERVER)client_edit.php")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let parameter:String = "token_autoclass=aUu0u0t9o0c3b78deu3m0p6hcudb2b31e439Cbcc1be8acb&name=\(jsonParams["name"] as! String)&rut=\(jsonParams["rut"] as! String)&address=\(jsonParams["address"] as! String)&email=\(jsonParams["email"] as! String)&phone=\(jsonParams["phone"] as! String)"
        let parameterData:Data = parameter.data(using: String.Encoding.utf8)!
        request.httpBody = parameterData
        
        let task = URLSession.shared.dataTask(with: request){data,response,error in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Response \(httpResponse.statusCode)")
                
                if httpResponse.statusCode == 200 {
                    
                    if error == nil {
                        
                        DispatchQueue.main.async(execute: {
                            print("async")
                            
                            do {
                                let dataString = NSString(data:data!, encoding: String.Encoding.utf8.rawValue)
                                print("dataString: \(dataString!)")
                                
                                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]
                                
                                let request = json["request"] as! String
                                if request == "ok" {
                                    
                                    let item = json["client"] as! [String: Any]
                                    do {
                                        let jsonData = try JSONSerialization.data(withJSONObject: item, options: .prettyPrinted)
                                        
                                        do {
                                            // Decode data to object
                                            let jsonDecoder = JSONDecoder()
                                            client = try jsonDecoder.decode(Client.self, from: jsonData)
                                        } catch {
                                            print("catch initWithJSON \(error)")
                                        }
                                        
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                    
                                    callBack(client)
                                    
                                } else {
                                    Utils.showAlert(message: json["message"] as! String, VC: VC)
                                }
                                
                            } catch {
                                print("catch request")
                            }
                            
                        })
                        
                    } else {
                        Utils.showAlert(message: Utils.TRY_AGAIN_TEXT, VC: VC)
                    }
                    
                } else {
                    Utils.showAlert(message: Utils.TRY_AGAIN_TEXT, VC: VC)
                }
                
            }
            
        }
        task.resume()
        
    }
    
    static func addClient(VC: UIViewController, jsonParams: [String: Any], callBack:@escaping (Client) -> Void){
        
        print("addClient")
        
        var client: Client!
        
        let url = URL(string:"\(Utils.URL_SERVER)client_add.php")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let parameter:String = "token_autoclass=aUu0u0t9o0c3b78deu3m0p6hcudb2b31e439Cbcc1be8acb&name=\(jsonParams["name"] as! String)&rut=\(jsonParams["rut"] as! String)&address=\(jsonParams["address"] as! String)&email=\(jsonParams["email"] as! String)&phone=\(jsonParams["phone"] as! String)"
        let parameterData:Data = parameter.data(using: String.Encoding.utf8)!
        request.httpBody = parameterData
        
        let task = URLSession.shared.dataTask(with: request){data,response,error in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Response \(httpResponse.statusCode)")
                
                if httpResponse.statusCode == 200 {
                    
                    if error == nil {
                        
                        DispatchQueue.main.async(execute: {
                            print("async")
                            
                            do {
                                let dataString = NSString(data:data!, encoding: String.Encoding.utf8.rawValue)
                                print("dataString: \(dataString!)")
                                
                                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]
                                
                                let request = json["request"] as! String
                                if request == "ok" {
                                    
                                    let item = json["client"] as! [String: Any]
                                    do {
                                        let jsonData = try JSONSerialization.data(withJSONObject: item, options: .prettyPrinted)
                                        
                                        do {
                                            // Decode data to object
                                            let jsonDecoder = JSONDecoder()
                                            client = try jsonDecoder.decode(Client.self, from: jsonData)
                                        } catch {
                                            print("catch initWithJSON \(error)")
                                        }
                                        
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                    
                                    callBack(client)
                                    
                                } else {
                                    Utils.showAlert(message: json["message"] as! String, VC: VC)
                                }
                                
                            } catch {
                                print("catch request")
                            }
                            
                        })
                        
                    } else {
                        Utils.showAlert(message: Utils.TRY_AGAIN_TEXT, VC: VC)
                    }
                    
                } else {
                    Utils.showAlert(message: Utils.TRY_AGAIN_TEXT, VC: VC)
                }
                
            }
            
        }
        task.resume()
        
    }
    
    static func getClients(VC: UIViewController, callBack:@escaping ([Client]) -> Void){
        
        print("getClients")
        
        var listClients: [Client] = []
        
        let url = URL(string:"\(Utils.URL_SERVER)clients.php")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let parameter:String = "token_autoclass=aUu0u0t9o0c3b78deu3m0p6hcudb2b31e439Cbcc1be8acb"
        let parameterData:Data = parameter.data(using: String.Encoding.utf8)!
        request.httpBody = parameterData
        
        let task = URLSession.shared.dataTask(with: request){data,response,error in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Response \(httpResponse.statusCode)")
                
                if httpResponse.statusCode == 200 {
                    
                    if error == nil {
                        
                        DispatchQueue.main.async(execute: {
                            print("async")
                            
                            do {
                                let dataString = NSString(data:data!, encoding: String.Encoding.utf8.rawValue)
                                print("dataString: \(dataString!)")
                                
                                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]
                                
                                let request = json["request"] as! String
                                if request == "ok" {
                                    
                                    let items = json["list"] as! [[String: Any]]
                                    for item in items {
                                        do {
                                            let jsonData = try JSONSerialization.data(withJSONObject: item, options: .prettyPrinted)
                                            
                                            do {
                                                // Decode data to object
                                                let jsonDecoder = JSONDecoder()
                                                let client = try jsonDecoder.decode(Client.self, from: jsonData)
                                                listClients.append(client)
                                            } catch {
                                                print("catch initWithJSON \(error)")
                                            }
                                            
                                        } catch {
                                            print(error.localizedDescription)
                                        }
                                    }
                                    
                                    callBack(listClients)
                                    
                                } else {
                                    Utils.showAlert(message: json["message"] as! String, VC: VC)
                                }
                                
                            } catch {
                                print("catch request")
                            }
                            
                        })
                        
                    } else {
                        Utils.showAlert(message: Utils.TRY_AGAIN_TEXT, VC: VC)
                    }
                    
                } else {
                    Utils.showAlert(message: Utils.TRY_AGAIN_TEXT, VC: VC)
                }
                
            }
            
        }
        task.resume()
        
    }
    
}

class BrandService {
    
    static func deleteBrand(VC: UIViewController, jsonParams: [String: Any], callBack:@escaping (String) -> Void){
        
        print("deleteBrand")
        
        let url = URL(string:"\(Utils.URL_SERVER)brand_delete.php")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let parameter:String = "token_autoclass=aUu0u0t9o0c3b78deu3m0p6hcudb2b31e439Cbcc1be8acb&id=\(jsonParams["id"] as! String)"
        let parameterData:Data = parameter.data(using: String.Encoding.utf8)!
        request.httpBody = parameterData
        
        let task = URLSession.shared.dataTask(with: request){data,response,error in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Response \(httpResponse.statusCode)")
                
                if httpResponse.statusCode == 200 {
                    
                    if error == nil {
                        
                        DispatchQueue.main.async(execute: {
                            print("async")
                            
                            do {
                                let dataString = NSString(data:data!, encoding: String.Encoding.utf8.rawValue)
                                print("dataString: \(dataString!)")
                                
                                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]
                                
                                let request = json["request"] as! String
                                if request == "ok" {
                                    
                                    callBack("ok")
                                    
                                } else {
                                    Utils.showAlert(message: json["message"] as! String, VC: VC)
                                }
                                
                            } catch {
                                print("catch request")
                            }
                            
                        })
                        
                    } else {
                        Utils.showAlert(message: Utils.TRY_AGAIN_TEXT, VC: VC)
                    }
                    
                } else {
                    Utils.showAlert(message: Utils.TRY_AGAIN_TEXT, VC: VC)
                }
                
            }
            
        }
        task.resume()
        
    }
    
    static func editBrand(VC: UIViewController, jsonParams: [String: Any], callBack:@escaping (Brand) -> Void){
        
        print("editBrand")
        
        var brand: Brand!
        
        let url = URL(string:"\(Utils.URL_SERVER)brand_edit.php")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let parameter:String = "token_autoclass=aUu0u0t9o0c3b78deu3m0p6hcudb2b31e439Cbcc1be8acb&name=\(jsonParams["name"] as! String)&id=\(jsonParams["id"] as! String)"
        let parameterData:Data = parameter.data(using: String.Encoding.utf8)!
        request.httpBody = parameterData
        
        let task = URLSession.shared.dataTask(with: request){data,response,error in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Response \(httpResponse.statusCode)")
                
                if httpResponse.statusCode == 200 {
                    
                    if error == nil {
                        
                        DispatchQueue.main.async(execute: {
                            print("async")
                            
                            do {
                                let dataString = NSString(data:data!, encoding: String.Encoding.utf8.rawValue)
                                print("dataString: \(dataString!)")
                                
                                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]
                                
                                let request = json["request"] as! String
                                if request == "ok" {
                                    
                                    let item = json["brand"] as! [String: Any]
                                    do {
                                        let jsonData = try JSONSerialization.data(withJSONObject: item, options: .prettyPrinted)
                                        
                                        do {
                                            // Decode data to object
                                            let jsonDecoder = JSONDecoder()
                                            brand = try jsonDecoder.decode(Brand.self, from: jsonData)
                                        } catch {
                                            print("catch initWithJSON \(error)")
                                        }
                                        
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                    
                                    callBack(brand)
                                    
                                } else {
                                    Utils.showAlert(message: json["message"] as! String, VC: VC)
                                }
                                
                            } catch {
                                print("catch request")
                            }
                            
                        })
                        
                    } else {
                        Utils.showAlert(message: Utils.TRY_AGAIN_TEXT, VC: VC)
                    }
                    
                } else {
                    Utils.showAlert(message: Utils.TRY_AGAIN_TEXT, VC: VC)
                }
                
            }
            
        }
        task.resume()
        
    }
    
    static func addBrand(VC: UIViewController, jsonParams: [String: Any], callBack:@escaping (Brand) -> Void){
        
        print("addBrand")
        
        var brand: Brand!
        
        let url = URL(string:"\(Utils.URL_SERVER)brand_add.php")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let parameter:String = "token_autoclass=aUu0u0t9o0c3b78deu3m0p6hcudb2b31e439Cbcc1be8acb&name=\(jsonParams["name"] as! String)"
        let parameterData:Data = parameter.data(using: String.Encoding.utf8)!
        request.httpBody = parameterData
        
        let task = URLSession.shared.dataTask(with: request){data,response,error in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Response \(httpResponse.statusCode)")
                
                if httpResponse.statusCode == 200 {
                    
                    if error == nil {
                        
                        DispatchQueue.main.async(execute: {
                            print("async")
                            
                            do {
                                let dataString = NSString(data:data!, encoding: String.Encoding.utf8.rawValue)
                                print("dataString: \(dataString!)")
                                
                                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]
                                
                                let request = json["request"] as! String
                                if request == "ok" {
                                    
                                    let item = json["brand"] as! [String: Any]
                                    do {
                                        let jsonData = try JSONSerialization.data(withJSONObject: item, options: .prettyPrinted)
                                        
                                        do {
                                            // Decode data to object
                                            let jsonDecoder = JSONDecoder()
                                            brand = try jsonDecoder.decode(Brand.self, from: jsonData)
                                        } catch {
                                            print("catch initWithJSON \(error)")
                                        }
                                        
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                    
                                    callBack(brand)
                                    
                                } else {
                                    Utils.showAlert(message: json["message"] as! String, VC: VC)
                                }
                                
                            } catch {
                                print("catch request")
                            }
                            
                        })
                        
                    } else {
                        Utils.showAlert(message: Utils.TRY_AGAIN_TEXT, VC: VC)
                    }
                    
                } else {
                    Utils.showAlert(message: Utils.TRY_AGAIN_TEXT, VC: VC)
                }
                
            }
            
        }
        task.resume()
        
    }
    
    static func getBrands(VC: UIViewController, callBack:@escaping ([Brand]) -> Void){
        
        print("getBrands")
        
        var listBrand: [Brand] = []
        
        let url = URL(string:"\(Utils.URL_SERVER)brands.php")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let parameter:String = "token_autoclass=aUu0u0t9o0c3b78deu3m0p6hcudb2b31e439Cbcc1be8acb"
        let parameterData:Data = parameter.data(using: String.Encoding.utf8)!
        request.httpBody = parameterData
        
        let task = URLSession.shared.dataTask(with: request){data,response,error in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Response \(httpResponse.statusCode)")
                
                if httpResponse.statusCode == 200 {
                    
                    if error == nil {
                        
                        DispatchQueue.main.async(execute: {
                            print("async")
                            
                            do {
                                let dataString = NSString(data:data!, encoding: String.Encoding.utf8.rawValue)
                                print("dataString: \(dataString!)")
                                
                                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]
                                
                                let request = json["request"] as! String
                                if request == "ok" {
                                    
                                    let items = json["list"] as! [[String: Any]]
                                    for item in items {
                                        do {
                                            let jsonData = try JSONSerialization.data(withJSONObject: item, options: .prettyPrinted)
                                            
                                            do {
                                                // Decode data to object
                                                let jsonDecoder = JSONDecoder()
                                                let brand = try jsonDecoder.decode(Brand.self, from: jsonData)
                                                listBrand.append(brand)
                                            } catch {
                                                print("catch initWithJSON \(error)")
                                            }
                                            
                                        } catch {
                                            print(error.localizedDescription)
                                        }
                                    }
                                    
                                    callBack(listBrand)
                                    
                                } else {
                                    Utils.showAlert(message: json["message"] as! String, VC: VC)
                                }
                                
                            } catch {
                                print("catch request")
                            }
                            
                        })
                        
                    } else {
                        Utils.showAlert(message: Utils.TRY_AGAIN_TEXT, VC: VC)
                    }
                    
                } else {
                    Utils.showAlert(message: Utils.TRY_AGAIN_TEXT, VC: VC)
                }
                
            }
            
        }
        task.resume()
        
    }
    
}

class ContractService {
    
    static func deleteContract(VC: UIViewController, jsonParams: [String: Any], callBack:@escaping (String) -> Void){
        
        print("deleteContract")
        
        let url = URL(string:"\(Utils.URL_SERVER)contract_delete.php")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let parameter:String = "token_autoclass=aUu0u0t9o0c3b78deu3m0p6hcudb2b31e439Cbcc1be8acb&id=\(jsonParams["id"] as! String)"
        let parameterData:Data = parameter.data(using: String.Encoding.utf8)!
        request.httpBody = parameterData
        
        let task = URLSession.shared.dataTask(with: request){data,response,error in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Response \(httpResponse.statusCode)")
                
                if httpResponse.statusCode == 200 {
                    
                    if error == nil {
                        
                        DispatchQueue.main.async(execute: {
                            print("async")
                            
                            do {
                                let dataString = NSString(data:data!, encoding: String.Encoding.utf8.rawValue)
                                print("dataString: \(dataString!)")
                                
                                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]
                                
                                let request = json["request"] as! String
                                if request == "ok" {
                                    
                                    callBack("ok")
                                    
                                } else {
                                    Utils.showAlert(message: json["message"] as! String, VC: VC)
                                }
                                
                            } catch {
                                print("catch request")
                            }
                            
                        })
                        
                    } else {
                        Utils.showAlert(message: Utils.TRY_AGAIN_TEXT, VC: VC)
                    }
                    
                } else {
                    Utils.showAlert(message: Utils.TRY_AGAIN_TEXT, VC: VC)
                }
                
            }
            
        }
        task.resume()
        
    }
    
    static func getContracts(VC: UIViewController, callBack:@escaping ([Contract]) -> Void){
        
        print("getContracts")
        
        var listContracts: [Contract] = []
        
        let url = URL(string:"\(Utils.URL_SERVER)contracts.php")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let parameter:String = "token_autoclass=aUu0u0t9o0c3b78deu3m0p6hcudb2b31e439Cbcc1be8acb"
        let parameterData:Data = parameter.data(using: String.Encoding.utf8)!
        request.httpBody = parameterData
        
        let task = URLSession.shared.dataTask(with: request){data,response,error in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Response \(httpResponse.statusCode)")
                
                if httpResponse.statusCode == 200 {
                    
                    if error == nil {
                        
                        DispatchQueue.main.async(execute: {
                            print("async")
                            
                            do {
                                let dataString = NSString(data:data!, encoding: String.Encoding.utf8.rawValue)
                                print("dataString: \(dataString!)")
                                
                                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]
                                
                                let request = json["request"] as! String
                                if request == "ok" {
                                    
                                    let items = json["list"] as! [[String: Any]]
                                    for item in items {
                                        do {
                                            let jsonData = try JSONSerialization.data(withJSONObject: item, options: .prettyPrinted)
                                            
                                            do {
                                                // Decode data to object
                                                let jsonDecoder = JSONDecoder()
                                                let contract = try jsonDecoder.decode(Contract.self, from: jsonData)
                                                
                                                let JSONClient = item["client"] as! [String: Any]
                                                let jsonDataClient = try JSONSerialization.data(withJSONObject: JSONClient, options: .prettyPrinted)
                                                let client = try jsonDecoder.decode(Client.self, from: jsonDataClient)
                                                contract.client = client
                                                
                                                let JSONCar = item["car"] as! [String: Any]
                                                let jsonDataCar = try JSONSerialization.data(withJSONObject: JSONCar, options: .prettyPrinted)
                                                let car = try jsonDecoder.decode(Car.self, from: jsonDataCar)
                                                
                                                let JSONBrand = JSONCar["brand"] as! [String: Any]
                                                let jsonDataBrand = try JSONSerialization.data(withJSONObject: JSONBrand, options: .prettyPrinted)
                                                let brand = try jsonDecoder.decode(Brand.self, from: jsonDataBrand)
                                                car.brand = brand
                                                
                                                contract.car = car
                                                
                                                listContracts.append(contract)
                                            } catch {
                                                print("catch initWithJSON \(error)")
                                            }
                                            
                                        } catch {
                                            print(error.localizedDescription)
                                        }
                                    }
                                    
                                    callBack(listContracts)
                                    
                                } else {
                                    Utils.showAlert(message: json["message"] as! String, VC: VC)
                                }
                                
                            } catch {
                                print("catch request")
                            }
                            
                        })
                        
                    } else {
                        Utils.showAlert(message: Utils.TRY_AGAIN_TEXT, VC: VC)
                    }
                    
                } else {
                    Utils.showAlert(message: Utils.TRY_AGAIN_TEXT, VC: VC)
                }
                
            }
            
        }
        task.resume()
        
    }
    
    static func newContract(VC: UIViewController, jsonParams: [String: Any], callBack:@escaping (Contract) -> Void){
        
        print("newContract")
        
        var contract: Contract!
        
        let url = URL(string:"\(Utils.URL_SERVER)contract_add.php")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        let boundary = "---------------------------14737809831466499882746641449"
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body: Data = Data()
        
        var linea:String = ""
        for (key, value) in jsonParams {
            if key != "firma1" && key != "firma2" && key != "firma1Datos" && key != "firma2Datos" && key != "firma1Downloading" && key != "firma2Downloading" && key != "client" && key != "car" {
                linea = "--\(boundary)\r\n"
                body.append(linea.data(using: String.Encoding.utf8)!)
                linea = "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n"
                body.append(linea.data(using: String.Encoding.utf8)!)
                linea = value as! String
                //print("VALOR \(linea)")
                body.append(linea.data(using: String.Encoding.utf8)!)
                linea = "\r\n"
                body.append(linea.data(using: String.Encoding.utf8)!)
            }
        }
        
        linea = "--\(boundary)\r\n"
        body.append(linea.data(using: String.Encoding.utf8)!)
        linea = "Content-Disposition: form-data; name=\"token_autoclass\"\r\n\r\n"
        body.append(linea.data(using: String.Encoding.utf8)!)
        linea = "aUu0u0t9o0c3b78deu3m0p6hcudb2b31e439Cbcc1be8acb"
        //print("VALOR \(linea)")
        body.append(linea.data(using: String.Encoding.utf8)!)
        linea = "\r\n"
        body.append(linea.data(using: String.Encoding.utf8)!)
        
        if jsonParams["firma1Datos"] != nil {
            linea = "\r\n--\(boundary)\r\n"
            body.append(linea.data(using: String.Encoding.utf8)!)
            linea = "Content-Disposition: form-data; name=\"firma1\"\r\n\r\n"
            body.append(linea.data(using: String.Encoding.utf8)!)
            linea = "firma1"
            body.append(linea.data(using: String.Encoding.utf8)!)
            linea = "\r\n--\(boundary)\r\n"
            body.append(linea.data(using: String.Encoding.utf8)!)
            linea = "Content-Disposition: form-data; name=\"firma1\"; filename=\"firma1.jpg\"\r\n"
            body.append(linea.data(using: String.Encoding.utf8)!)
            linea = "Content-Type: application/octet-stream\r\n\r\n"
            body.append(linea.data(using: String.Encoding.utf8)!)
            body.append(jsonParams["firma1Datos"] as! Data)
        }
        
        if jsonParams["firma2Datos"] != nil {
            linea = "\r\n--\(boundary)\r\n"
            body.append(linea.data(using: String.Encoding.utf8)!)
            linea = "Content-Disposition: form-data; name=\"firma2\"\r\n\r\n"
            body.append(linea.data(using: String.Encoding.utf8)!)
            linea = "firma2"
            body.append(linea.data(using: String.Encoding.utf8)!)
            linea = "\r\n--\(boundary)\r\n"
            body.append(linea.data(using: String.Encoding.utf8)!)
            linea = "Content-Disposition: form-data; name=\"firma2\"; filename=\"firma2.jpg\"\r\n"
            body.append(linea.data(using: String.Encoding.utf8)!)
            linea = "Content-Type: application/octet-stream\r\n\r\n"
            body.append(linea.data(using: String.Encoding.utf8)!)
            body.append(jsonParams["firma2Datos"] as! Data)
        }
        
        
        linea = "\r\n--\(boundary)--\r\n"
        body.append(linea.data(using: String.Encoding.utf8)!)
        
        request.httpBody = body
        
        let task = URLSession.shared.uploadTask(with: request, from: body) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Response \(httpResponse.statusCode)")
                
                if httpResponse.statusCode == 200 {
                    
                    if error == nil {
                        
                        DispatchQueue.main.async(execute: {
                            print("async")
                            
                            do {
                                let dataString = NSString(data:data!, encoding: String.Encoding.utf8.rawValue)
                                print("dataString: \(dataString!)")
                                
                                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]
                                
                                let request = json["request"] as! String
                                if request == "ok" {
                                    
                                    let item = json["contract"] as! [String: Any]
                                    do {
                                        let jsonData = try JSONSerialization.data(withJSONObject: item, options: .prettyPrinted)
                                        
                                        do {
                                            // Decode data to object
                                            let jsonDecoder = JSONDecoder()
                                            contract = try jsonDecoder.decode(Contract.self, from: jsonData)
                                        } catch {
                                            print("catch initWithJSON \(error)")
                                        }
                                        
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                    
                                    callBack(contract)
                                    
                                } else {
                                    Utils.showAlert(message: json["message"] as! String, VC: VC)
                                }
                                
                            } catch {
                                print("catch request")
                            }
                            
                        })
                        
                    } else {
                        Utils.showAlert(message: Utils.TRY_AGAIN_TEXT, VC: VC)
                    }
                    
                } else {
                    Utils.showAlert(message: Utils.TRY_AGAIN_TEXT, VC: VC)
                }
                
            }
            
        }
        
        task.resume()
        
    }
    
}
