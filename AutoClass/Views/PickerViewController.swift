//
//  PickerViewController.swift
//  AutoClass
//
//  Created by Jonathan Fajardo Roa on 5/21/19.
//  Copyright © 2019 JFR. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController {
    
    var indexPicker = 0
    var list : [String] = []
    
    var delegate : ViewPickerDelegate!
    
    @IBOutlet weak var btnBackground: UIButton!
    @IBOutlet weak var viewFrame: UIView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var picker: UIPickerView!
    @IBAction func cancel(_ sender: Any) {
        delegate.cancelPicker()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectP(_ sender: Any) {
        delegate.selectPicker(index: self.indexPicker)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        picker.delegate = self
        picker.dataSource = self
        
        picker.selectRow(self.indexPicker, inComponent: 0, animated: true)
        
    }

}

extension PickerViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.indexPicker = row
    }
    
}
