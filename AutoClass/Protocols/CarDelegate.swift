//
//  carDelegate.swift
//  AutoClass
//
//  Created by Jonathan Fajardo Roa on 5/8/19.
//  Copyright © 2019 JFR. All rights reserved.
//

import Foundation

protocol CarDelegate: NSObjectProtocol {
    func deleteCar(car: Car);
    func addCar(car: Car)
    func updateCar(car: Car)
}
