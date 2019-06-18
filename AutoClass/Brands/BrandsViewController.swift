//
//  BrandsViewController.swift
//  AutoClass
//
//  Created by Jonathan Fajardo Roa on 5/9/19.
//  Copyright © 2019 JFR. All rights reserved.
//

import UIKit

class BrandsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var table: UITableView!
    var listBrands : [Brand] = []
    
    @IBOutlet weak var btnNew: UIButton!
    @IBAction func new(_ sender: Any) {
        
        let newBrandVC = self.storyboard?.instantiateViewController(withIdentifier: "newBrandVC") as! NewBrandViewController
        self.navigationItem.title = ""
        newBrandVC.delegate = delegate
        self.navigationController?.pushViewController(newBrandVC, animated: true)
        
    }
    
    var delegate : BrandDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
        delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "MARCAS"
        
        loadData()
        
    }
    
    func loadData(){
        indicator.isHidden = false
        indicator.startAnimating()
        BrandService.getBrands(VC: self) { (list) in
            self.indicator.isHidden = true
            self.indicator.stopAnimating()
            self.listBrands = list
            self.table.reloadData()
        }
    }
    
    //TABLEVIEW
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listBrands.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let brand = listBrands[indexPath.row]
        
        let lblOption : UILabel = cell.viewWithTag(1) as! UILabel
        
        lblOption.text = brand.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newBrandVC = self.storyboard?.instantiateViewController(withIdentifier: "newBrandVC") as! NewBrandViewController
        self.navigationItem.title = ""
        newBrandVC.delegate = delegate
        newBrandVC.brand = listBrands[indexPath.row]
        self.navigationController?.pushViewController(newBrandVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            indicator.isHidden = false
            indicator.startAnimating()
            let brand : Brand = listBrands[indexPath.row]
            let dictionary : [String: Any] = ["id":brand.id!]
            self.listBrands.remove(at: indexPath.row)
            self.table.reloadData()
            BrandService.deleteBrand(VC: self, jsonParams: dictionary) { (result) in
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

extension BrandsViewController : BrandDelegate {
    
    func deleteBrand(brand: Brand) {
        print("deleteBrand")
        listBrands.removeAll(where: {$0.id == brand.id})
        table.reloadData()
    }
    
    func addBrand(brand: Brand) {
        print("addBrand")
        listBrands.append(brand)
        table.reloadData()
    }
    
    func updateBrand(brand: Brand) {
        print("updateBrand")
        table.reloadData()
    }
    
    
}
