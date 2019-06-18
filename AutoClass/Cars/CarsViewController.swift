//
//  CarsViewController.swift
//  AutoClass
//
//  Created by Jonathan Fajardo Roa on 5/9/19.
//  Copyright © 2019 JFR. All rights reserved.
//

import UIKit

class CarsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var contract : Contract!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var table: UITableView!
    var listCars : [Car] = []
    
    @IBOutlet weak var btnNew: UIButton!
    @IBAction func new(_ sender: Any) {
        
        let newCarVC = self.storyboard?.instantiateViewController(withIdentifier: "newCarVC") as! NewCarViewController
        self.navigationItem.title = ""
        newCarVC.delegate = delegate
        self.navigationController?.pushViewController(newCarVC, animated: true)
        
    }
    
    var delegate : CarDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
        delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "AUTOS"
        
        loadData()
        
    }
    
    func loadData(){
        indicator.isHidden = false
        indicator.startAnimating()
        
        CarService.getCars(VC: self) { (list) in
            self.indicator.isHidden = true
            self.indicator.stopAnimating()
            self.listCars = list
            self.table.reloadData()
        }
        
    }
    
    //TABLEVIEW
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let car = listCars[indexPath.row]
        
        let lblOption : UILabel = cell.viewWithTag(1) as! UILabel
        
        lblOption.text = "\(car.brand.name!) | \(car.model!) | \(car.patent!) | \(car.km!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if contract != nil {
            
            contract.car = listCars[indexPath.row]
            self.navigationController?.popViewController(animated: true)
            
        } else {
            
            let newCarVC = self.storyboard?.instantiateViewController(withIdentifier: "newCarVC") as! NewCarViewController
            self.navigationItem.title = ""
            newCarVC.delegate = delegate
            newCarVC.car = listCars[indexPath.row]
            self.navigationController?.pushViewController(newCarVC, animated: true)
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            indicator.isHidden = false
            indicator.startAnimating()
            let car : Car = listCars[indexPath.row]
            let dictionary : [String: Any] = ["id":car.id!]
            self.listCars.remove(at: indexPath.row)
            self.table.reloadData()
            CarService.deleteCar(VC: self, jsonParams: dictionary) { (result) in
                self.indicator.isHidden = true
                self.indicator.stopAnimating()
                self.table.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Eliminar"
    }
    
}

extension CarsViewController : CarDelegate {
    func deleteCar(car: Car) {
        print("deleteCar")
        listCars.removeAll(where: {$0.id == car.id})
        table.reloadData()
    }
    
    func addCar(car: Car) {
        print("addCar")
        listCars.append(car)
        table.reloadData()
    }
    
    func updateCar(car: Car) {
        print("updateCar")
        table.reloadData()
    }

}
