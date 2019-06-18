//
//  NewContractViewController.swift
//  AutoClass
//
//  Created by Jonathan Fajardo Roa on 6/6/19.
//  Copyright © 2019 JFR. All rights reserved.
//

import UIKit

class NewContractViewController: UIViewController, UITextFieldDelegate {
    
    let notificationOpenKeyboard = NotificationCenter.default
    let notificationCloseKeyboard = NotificationCenter.default
    weak var fieldActive: UITextField!
    var tabGesture = UITapGestureRecognizer()

    var delegate : ContractDelegate!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var txtClient: UITextField!
    @IBOutlet weak var btnClient: UIButton!
    @IBAction func selectClient(_ sender: Any) {
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "clientsVC") as! ClientsViewController
        self.navigationItem.title = ""
        VC.contract = contract
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    
    @IBOutlet weak var txtCar: UITextField!
    @IBOutlet weak var btnCar: UIButton!
    @IBAction func selectCar(_ sender: Any) {
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "carsVC") as! CarsViewController
        self.navigationItem.title = ""
        VC.contract = contract
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    @IBOutlet weak var btnSave: UIButton!
    @IBAction func save(_ sender: Any) {
        
        if txtClient.text!.count > 0 && txtCar.text!.count > 0 && contract.firma1Datos != nil && contract.firma2Datos != nil && txtContractValue.text!.count > 0 && txtCarValue.text!.count > 0 {
            
            indicator.isHidden = false
            indicator.startAnimating()
            
            var dictionary : [String : Any] = contract.toDictionary(contract: contract)
            dictionary.updateValue(contract.firma1Datos!, forKey: "firma1Datos")
            dictionary.updateValue(contract.firma2Datos!, forKey: "firma2Datos")
            dictionary.updateValue(txtContractValue.text!, forKey: "precio_contrato")
            dictionary.updateValue(txtCarValue.text!, forKey: "precio_vehiculo")
            
            ContractService.newContract(VC: self, jsonParams: dictionary) { (Contract) in
                self.indicator.isHidden = true
                self.indicator.stopAnimating()
                self.delegate.updateContract(contract: Contract)
                self.contract = Contract
                self.navigationController?.popViewController(animated: true)
            }
            
        } else {
            Utils.showAlert(message: Utils.VERIFY_FIELDS, VC: self)
        }
        
    }
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var txtFirma1: UITextField!
    @IBAction func firma1(_ sender: Any) {
        
        let signatureVC = self.storyboard?.instantiateViewController(withIdentifier: "signatureVC") as! SignatureViewController
        self.navigationItem.title = ""
        signatureVC.option = 1
        signatureVC.contract = contract
        self.navigationController?.pushViewController(signatureVC, animated: true)
        
    }
    
    @IBOutlet weak var txtFirma2: UITextField!
    @IBAction func firma2(_ sender: Any) {
        
        let signatureVC = self.storyboard?.instantiateViewController(withIdentifier: "signatureVC") as! SignatureViewController
        self.navigationItem.title = ""
        signatureVC.option = 2
        signatureVC.contract = contract
        self.navigationController?.pushViewController(signatureVC, animated: true)
        
    }
    
    var contract: Contract!
    
    @IBOutlet weak var txtContractValue: UITextField!
    @IBOutlet weak var txtCarValue: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        indicator.isHidden = true
        contract = Contract(id: "", client_id: "", car_id: "", precio_contrato: "", precio_vehiculo: "", firma1: "", firma2: "", number: "", created_date: "", created_time: "", state: "")
        
        delegate = self
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "NUEVO CONTRATO"
        
        if contract.firma1Datos != nil {
            txtFirma1.text = "OK"
        }
        
        if contract.firma2Datos != nil {
            txtFirma2.text = "OK"
        }
        
        if contract.client != nil {
            txtClient.text = contract.client.name
            contract.client_id = contract.client.id
        }
        
        if contract.car != nil {
            txtCar.text = contract.car.patent
            contract.car_id = contract.car.id
        }
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 650)
        tabGesture.addTarget(self, action: #selector(hideKeyboard(sender:)))
        scrollView.addGestureRecognizer(tabGesture)
        
        txtContractValue.delegate = self
        txtCarValue.delegate = self
        
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

extension NewContractViewController : ContractDelegate {
    
    func deleteContract(contract: Contract) {
        
    }
    
    func addContract(contract: Contract) {
        
    }
    
    func updateContract(contract: Contract) {
        self.contract = contract
    }
    
    
}
