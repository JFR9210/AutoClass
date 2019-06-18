//
//  NewBrandViewController.swift
//  AutoClass
//
//  Created by Jonathan Fajardo Roa on 5/9/19.
//  Copyright © 2019 JFR. All rights reserved.
//

import UIKit

class NewBrandViewController: UIViewController, UITextFieldDelegate {

    var brand : Brand?
    var brandID : String = ""
    var delegate : BrandDelegate!
    
    let notificationOpenKeyboard = NotificationCenter.default
    let notificationCloseKeyboard = NotificationCenter.default
    weak var fieldActive: UITextField!
    var tabGesture = UITapGestureRecognizer()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var btnSave: UIButton!
    @IBAction func save(_ sender: Any) {
        
        if txtName.text!.count > 0 {
            indicator.isHidden = false
            indicator.startAnimating()
            
            let dictionary : [String: Any] = ["name":txtName.text!, "id":brandID]
            
            if brand != nil {
                BrandService.editBrand(VC: self, jsonParams: dictionary) { (Brand) in
                    self.indicator.isHidden = true
                    self.indicator.stopAnimating()
                    self.delegate.updateBrand(brand: Brand)
                    self.brand = Brand
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                BrandService.addBrand(VC: self, jsonParams: dictionary) { (Brand) in
                    self.indicator.isHidden = true
                    self.indicator.stopAnimating()
                    self.delegate.addBrand(brand: Brand)
                    self.navigationController?.popViewController(animated: true)
                }
            }
            
        } else {
            Utils.showAlert(message: Utils.VERIFY_FIELDS, VC: self)
        }
        
    }
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        indicator.isHidden = true
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "NUEVA MARCA"
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollView.frame.height)
        tabGesture.addTarget(self, action: #selector(hideKeyboard(sender:)))
        scrollView.addGestureRecognizer(tabGesture)
        
        txtName.delegate = self
        
        if brand != nil {
            brandID = brand!.id
            txtName.text = brand!.name
            btnSave.setTitle("ACTUALIZAR", for: .normal)
            self.navigationItem.title = "DETALLE MARCA"
        }
        
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
