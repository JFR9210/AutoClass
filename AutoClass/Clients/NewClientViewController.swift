//
//  NewClientViewController.swift
//  AutoClass
//
//  Created by Jonathan Fajardo Roa on 5/9/19.
//  Copyright © 2019 JFR. All rights reserved.
//

import UIKit

class NewClientViewController: UIViewController, UITextFieldDelegate {

    var client : Client?
    
    var delegate : ClientDelegate!
    
    let notificationOpenKeyboard = NotificationCenter.default
    let notificationCloseKeyboard = NotificationCenter.default
    weak var fieldActive: UITextField!
    var tabGesture = UITapGestureRecognizer()
    
    @IBOutlet weak var btnSave: UIButton!
    @IBAction func save(_ sender: Any) {
        
//        let txt = txtRUT.text!.uppercased()
        
//        var rutSinDig = String(txt[..<txt.index(txt.startIndex, offsetBy: txt.count - 1)])
//        let digito = String(txt[txt.index(txt.startIndex, offsetBy: txt.count - 1)...])
//        rutSinDig = String(txt[..<rutSinDig.index(rutSinDig.startIndex, offsetBy: rutSinDig.count - 1)])
//
//        if !RutValidator.isValid(rut: rutSinDig, verifier: digito) {
//            Utils.showAlert(message: "RUT incorrecto", VC: self)
//            return
//        }
        
        if !Utils.isEmail(email: txtEmail.text!) {
            Utils.showAlert(message: "Correo electrónico incorrecto", VC: self)
            return
        }
        
        if txtRUT.text!.count > 0 && txtName.text!.count > 0 && txtAddress.text!.count > 0 && txtPhone.text!.count > 7 {
            indicator.isHidden = false
            indicator.startAnimating()
            let dictionary : [String: Any] = ["name":txtName.text!, "rut":txtRUT.text!, "address":txtAddress.text!, "email":txtEmail.text!, "phone":txtPhone.text!]
            
            if client != nil {
                ClientService.editClient(VC: self, jsonParams: dictionary) { (Client) in
                    self.indicator.isHidden = true
                    self.indicator.stopAnimating()
                    self.delegate.updateClient(client: Client)
                    self.client = Client
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                ClientService.addClient(VC: self, jsonParams: dictionary) { (Client) in
                    self.indicator.isHidden = true
                    self.indicator.stopAnimating()
                    self.delegate.addClient(client: Client)
                    self.navigationController?.popViewController(animated: true)
                }
            }
            
        } else {
            Utils.showAlert(message: Utils.VERIFY_FIELDS, VC: self)
        }
        
    }
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var lblRUT: UILabel!
    @IBOutlet weak var txtRUT: UITextField!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        indicator.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "NUEVO CLIENTE"
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 545)
        tabGesture.addTarget(self, action: #selector(hideKeyboard(sender:)))
        scrollView.addGestureRecognizer(tabGesture)
        
        txtName.delegate = self
        txtRUT.delegate = self
        txtAddress.delegate = self
        txtEmail.delegate = self
        txtPhone.delegate = self
        
        if client != nil {
            btnSave.setTitle("ACTUALIZAR", for: .normal)
            txtName.text = client!.name
            txtRUT.text = client!.rut
            txtAddress.text = client!.address
            txtEmail.text = client!.mail
            txtPhone.text = client!.phone
            txtRUT.isEnabled = false
            self.navigationItem.title = "DETALLE CLIENTE"
            
//            let barButtonItem : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(contracts))
//            let barButtonItem : UIBarButtonItem = UIBarButtonItem(title: "Contratos", style: UIBarButtonItem.Style.plain, target: self, action: #selector(contracts))
//            self.navigationItem.rightBarButtonItem = barButtonItem
        }
        
    }
    
    @objc func contracts(){
        
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
