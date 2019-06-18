//
//  ContractDelegate.swift
//  AutoClass
//
//  Created by Jonathan Fajardo Roa on 6/6/19.
//  Copyright © 2019 JFR. All rights reserved.
//

import Foundation

protocol ContractDelegate: NSObjectProtocol {
    func deleteContract(contract: Contract);
    func addContract(contract: Contract)
    func updateContract(contract: Contract)
}
