//
//  brandDelegate.swift
//  AutoClass
//
//  Created by Jonathan Fajardo Roa on 5/8/19.
//  Copyright © 2019 JFR. All rights reserved.
//

import Foundation

protocol BrandDelegate: NSObjectProtocol {
    func deleteBrand(brand: Brand);
    func addBrand(brand: Brand)
    func updateBrand(brand: Brand)
}
