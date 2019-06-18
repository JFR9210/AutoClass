//
//  NewCarViewController.swift
//  AutoClass
//
//  Created by Jonathan Fajardo Roa on 5/9/19.
//  Copyright © 2019 JFR. All rights reserved.
//

import UIKit

class NewCarViewController: UIViewController, UITextFieldDelegate {

    var typePicker : String = "BRANDS"
    var indexBrand : Int = 0
    var listBrands : [Brand] = []
    var delegatePicker : ViewPickerDelegate!
    
    var delegate : CarDelegate!
    var car : Car?
    var carID : String = ""
    
    let notificationOpenKeyboard = NotificationCenter.default
    let notificationCloseKeyboard = NotificationCenter.default
    weak var fieldActive: UITextField!
    var tabGesture = UITapGestureRecognizer()
    
    @IBOutlet weak var lblPatent: UILabel!
    @IBOutlet weak var txtPatent: UITextField!
    @IBOutlet weak var lblBrand: UILabel!
    @IBOutlet weak var txtBrand: UITextField!
    @IBOutlet weak var btnBrand: UIButton!
    
    @IBAction func selectBrand(_ sender: Any) {
        
        self.typePicker = "BRANDS"
        
        var list : [String] = []
        for brand in listBrands {
            list.append(brand.name)
        }
        
        let pickerVC = self.storyboard?.instantiateViewController(withIdentifier: "pickerVC") as! PickerViewController
        pickerVC.providesPresentationContextTransitionStyle = true
        pickerVC.definesPresentationContext = true
        pickerVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        pickerVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        pickerVC.delegate = self.delegatePicker
        pickerVC.indexPicker = self.indexBrand
        pickerVC.list = list
        self.present(pickerVC, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var lblModel: UILabel!
    @IBOutlet weak var txtModel: UITextField!
    @IBOutlet weak var lblVersion: UILabel!
    @IBOutlet weak var txtVersion: UITextField!
    @IBOutlet weak var lblKm: UILabel!
    @IBOutlet weak var txtKm: UITextField!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var txtYear: UITextField!
    @IBOutlet weak var lblColor: UILabel!
    @IBOutlet weak var txtColor: UITextField!
    
    @IBOutlet weak var btnSave: UIButton!
    @IBAction func save(_ sender: Any) {
        
        if txtPatent.text!.count > 0 && txtBrand.text!.count > 0 && txtModel.text!.count > 0 && txtVersion.text!.count > 0 && txtKm.text!.count > 0 && txtYear.text!.count > 0 && txtColor.text!.count > 0 {
            
            indicator.isHidden = false
            indicator.startAnimating()
            
            if car != nil {
                
                var dictionary : [String : Any] = car!.toDictionary(car: car!)
                dictionary.updateValue(carID, forKey: "id")
                dictionary.updateValue(txtPatent.text!, forKey: "patent")
                dictionary.updateValue(listBrands[indexBrand].id!, forKey: "brand_id")
                dictionary.updateValue(txtModel.text!, forKey: "model")
                dictionary.updateValue(txtVersion.text!, forKey: "version")
                dictionary.updateValue(txtKm.text!, forKey: "km")
                dictionary.updateValue(txtYear.text!, forKey: "year")
                dictionary.updateValue(txtColor.text!, forKey: "color")
                
                CarService.editCar(VC: self, jsonParams: dictionary) { (Car) in
                    self.indicator.isHidden = true
                    self.indicator.stopAnimating()
                    self.delegate.updateCar(car: Car)
                    self.car = Car
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                let dictionary : [String: Any] = ["id":carID, "patent":txtPatent.text!, "brand_id":listBrands[indexBrand].id!, "model":txtModel.text!, "version":txtVersion.text!, "km":txtKm.text!, "year":txtYear.text!, "color":txtColor.text!]
                CarService.addCar(VC: self, jsonParams: dictionary) { (Car) in
                    self.indicator.isHidden = true
                    self.indicator.stopAnimating()
                    self.delegate.addCar(car: Car)
                    self.navigationController?.popViewController(animated: true)
                }
            }
            
        } else {
            Utils.showAlert(message: Utils.VERIFY_FIELDS, VC: self)
        }
        
    }
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        indicator.isHidden = true
        delegatePicker = self
        delegate = self
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "NUEVO AUTO"
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 740)
        tabGesture.addTarget(self, action: #selector(hideKeyboard(sender:)))
        scrollView.addGestureRecognizer(tabGesture)
        
        txtPatent.delegate = self
        txtBrand.delegate = self
        txtModel.delegate = self
        txtVersion.delegate = self
        txtKm.delegate = self
        txtYear.delegate = self
        txtColor.delegate = self
        
        if car != nil {
            carID = car!.id
            txtPatent.text = car!.patent
            txtPatent.isEnabled = false
            txtModel.text = car!.model
            txtVersion.text = car!.version
            txtKm.text = car!.km
            txtYear.text = car!.year
            txtColor.text = car!.color
            btnSave.setTitle("ACTUALIZAR", for: .normal)
            self.navigationItem.title = "DETALLE AUTO"
            
//            let barButtonItem : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(form))
                        let barButtonItem : UIBarButtonItem = UIBarButtonItem(title: "Formulario", style: UIBarButtonItem.Style.plain, target: self, action: #selector(form))
            self.navigationItem.rightBarButtonItem = barButtonItem
            
        }
        
        BrandService.getBrands(VC: self) { (list) in
            self.indicator.isHidden = true
            self.indicator.stopAnimating()
            self.listBrands = list
            
            if self.car != nil {
                if let brand = self.listBrands.first(where: { $0.id == self.car!.brand_id }) {
                    self.txtBrand.text = brand.name
                }
                
                if let index = self.listBrands.firstIndex(where: { $0.id == self.car!.brand_id }) {
                    self.indexBrand = index
                }
            }
            
        }
        
    }
    
    @objc func form(){
        self.navigationItem.title = ""
        let formVC = self.storyboard?.instantiateViewController(withIdentifier: "formVC") as! FormViewController
        formVC.car = car
        formVC.delegate = delegate
        self.navigationController?.pushViewController(formVC, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //No escuchar mas la notificacion de teclado en esta vista
        notificationOpenKeyboard.removeObserver(self, name: UIWindow.keyboardWillShowNotification, object: nil)
        notificationCloseKeyboard.removeObserver(self, name: UIWindow.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        notificationOpenKeyboard.addObserver(self, selector: #selector(openKeyboard(notificacion:)), name: UIWindow.keyboardWillShowNotification, object: nil)
        
        notificationCloseKeyboard.addObserver(self, selector: #selector(closeKeyboard(notificacion:)), name: UIWindow.keyboardWillHideNotification, object: nil)
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        fieldActive = nil
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        fieldActive = textField
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (textField.text!.count >= 4 && range.length == 0 && textField == txtYear) {
            return false
        } else {
            return true
        }
        
    }
    
    @objc
    func openKeyboard(notificacion: Notification){
        print("Open keyboard")
        if let keyboardFrame: NSValue = notificacion.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            let edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            scrollView.contentInset = edgeInsets
            scrollView.scrollIndicatorInsets = edgeInsets
            scrollView.scrollRectToVisible(fieldActive.frame, animated: true)
            
        }
    }
    
    @objc
    func closeKeyboard(notificacion: Notification){
        print("Close keyboard")
        let edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        scrollView.contentInset = edgeInsets
        scrollView.scrollIndicatorInsets = edgeInsets
        //scrollView.scrollRectToVisible(fieldActive.frame, animated: true)
    }
    
    @objc func hideKeyboard(sender:UIPanGestureRecognizer){
        print("Hide keyboard")
        scrollView.endEditing(true)
    }
    
}

extension NewCarViewController : ViewPickerDelegate {
    func selectPicker(index : Int) {
        print("selectPicker")
        
        if typePicker == "BRANDS" {
            self.indexBrand = index
        }
        self.txtBrand.text = self.listBrands[indexBrand].name
    }
    
    func cancelPicker() {
        print("cancelPicker")
        
    }
    
}

extension NewCarViewController : CarDelegate {
    func deleteCar(car: Car) {
        
    }
    
    func addCar(car: Car) {
        
    }
    
    func updateCar(car: Car) {
        self.car = car
    }
    
    
}
