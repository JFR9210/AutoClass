//
//  viewPickerDelegate.swift
//  AutoClass
//
//  Created by Jonathan Fajardo Roa on 5/21/19.
//  Copyright © 2019 JFR. All rights reserved.
//

import Foundation

protocol ViewPickerDelegate : NSObjectProtocol {
    func selectPicker(index: Int);
    func cancelPicker();
}
