//
//  Utils.swift
//  AutoClass
//
//  Created by Jonathan Fajardo Roa on 5/9/19.
//  Copyright © 2019 JFR. All rights reserved.
//

import Foundation
import UIKit

class Utils : Decodable {
    
    static let URL_SERVER_IMG = "http://45.55.25.68/autoclass/"
    static let URL_SERVER = "http://45.55.25.68/autoclass/api/"
    static let TRY_AGAIN_TEXT = "Por favor intenta nuevamente"
    static let VERIFY_FIELDS = "Por favor verifique los campos"
    
    static func showAlert(message: String, VC: UIViewController) {
        let alert = UIAlertController(title: "AutoClass", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: {_ in
            
        }))
        VC.present(alert, animated: true, completion: nil)
    }
    
    static func jsonToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                return  try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
    
    static func isEmail(email: String) -> Bool {
        if email.lowercased().range(of: "@") != nil && email.lowercased().range(of: ".") != nil {
            return true
        } else {
            return false
        }
    }
    
    static func isCorrectPassword(password: String) -> Bool {
        
        var isNumberOK = false
        var isLetterOK = false
        var isLetterUppercaseOK = false
        
        let arrayNumbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
        let arrayLetter = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "ñ", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
        let arrayLetterUppercase = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "Ñ", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        
        for number in arrayNumbers {
            if password.range(of: number) != nil {
                isNumberOK = true
                break
            }
        }
        
        for letter in arrayLetter {
            if password.range(of: letter) != nil {
                isLetterOK = true
                break
            }
        }
        
        for letterUppercase in arrayLetterUppercase {
            if password.range(of: letterUppercase) != nil {
                isLetterUppercaseOK = true
                break
            }
        }
        
        if isNumberOK && isLetterOK && isLetterUppercaseOK {
            return true
        }
        
        return false
    }
    
}
