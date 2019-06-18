//
//  SignatureViewController.swift
//  AutoClass
//
//  Created by Jonathan Fajardo Roa on 6/7/19.
//  Copyright © 2019 JFR. All rights reserved.
//

import UIKit

class SignatureViewController: UIViewController {

    @IBOutlet weak var viewSignature: UIView!
    @IBOutlet weak var imgSignature: UIImageView!
    
    @IBOutlet weak var btnSave: UIButton!
    @IBAction func save(_ sender: Any) {
        
        UIGraphicsBeginImageContext(self.view.bounds.size)
        UIImage(named: "frame")?.draw(in: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        imgSignature.image?.draw(in: CGRect(x: self.view.frame.width / 2 - imgSignature.frame.width / 2, y: self.view.frame.height / 2 - imgSignature.frame.size.height / 2, width: imgSignature.frame.width, height: imgSignature.frame.height))
        
        if option == 1 {
            contract.firma1Datos = UIGraphicsGetImageFromCurrentImageContext()!.jpegData(compressionQuality: 1.0)
        } else {
            contract.firma2Datos = UIGraphicsGetImageFromCurrentImageContext()!.jpegData(compressionQuality: 1.0)
        }
        
        UIGraphicsEndImageContext()
        self.navigationController?.popViewController(animated: true)
        
    }
    
    var contract : Contract!
    var option: Int!
    var brush : CGFloat!
    var mouseSwiped : Bool!
    var lastPoint : CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        brush = 10.0
        
        if option == 1 && contract.firma1Datos != nil {
            imgSignature.image = UIImage(data: contract.firma1Datos)
        } else if contract.firma2Datos != nil {
            imgSignature.image = UIImage(data: contract.firma2Datos)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        if option == 1 {
            self.navigationItem.title = "FIRMA 1"
        } else {
            self.navigationItem.title = "FIRMA 2"
        }
        
        let btnClean : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(cleanSignature))
        self.navigationItem.rightBarButtonItem = btnClean
    }

    @objc func cleanSignature(){
        imgSignature.image = nil
        
        if option == 1 {
            contract.firma1Datos = nil
        } else {
            contract.firma2Datos = nil
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        mouseSwiped = false
        let touch : UITouch = touches.first!
        lastPoint = touch.location(in: self.view)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        mouseSwiped = true
        let touch : UITouch = touches.first!
        let currentPoint: CGPoint = touch.location(in: self.view)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.imgSignature.image?.draw(in: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
        UIGraphicsGetCurrentContext()?.setLineWidth(brush)
        UIGraphicsGetCurrentContext()?.setStrokeColor(UIColor.black.cgColor)
        UIGraphicsGetCurrentContext()?.beginPath()
        UIGraphicsGetCurrentContext()?.move(to: lastPoint)
        UIGraphicsGetCurrentContext()?.addLine(to: currentPoint)
        UIGraphicsGetCurrentContext()?.strokePath()
        
        self.imgSignature.image = UIGraphicsGetImageFromCurrentImageContext()
        self.imgSignature.alpha = 1.0
        UIGraphicsEndImageContext()
        
        lastPoint = currentPoint
        
    }
    
    
    
}
