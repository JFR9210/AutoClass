//
//  ContractsViewController.swift
//  AutoClass
//
//  Created by Jonathan Fajardo Roa on 6/6/19.
//  Copyright © 2019 JFR. All rights reserved.
//

import UIKit

class ContractsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    var listContracts : [Contract] = []
    
    @IBOutlet weak var btnNew: UIButton!
    @IBAction func new(_ sender: Any) {
        
        let newContractVC = self.storyboard?.instantiateViewController(withIdentifier: "newContractVC") as! NewContractViewController
        self.navigationItem.title = ""
        self.navigationController?.pushViewController(newContractVC, animated: true)
        
    }
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var delegate : ContractDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
        delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "CONTRATOS"
        
        loadData()
        
    }
    
    func loadData(){
        indicator.isHidden = false
        indicator.startAnimating()
        ContractService.getContracts(VC: self) { (list) in
            self.indicator.isHidden = true
            self.indicator.stopAnimating()
            self.listContracts = list
            self.table.reloadData()
        }
    }
    
    //TABLEVIEW
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listContracts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let contract = listContracts[indexPath.row]
        
        let lblOption : UILabel = cell.viewWithTag(1) as! UILabel
        
        lblOption.text = "\(contract.number!) | \(contract.car.brand.name!) | \(contract.car.model!) | \(contract.car.patent!) | \(contract.car.km!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pdfContractVC = self.storyboard?.instantiateViewController(withIdentifier: "pdfContractVC") as! PDFContractViewController
        self.navigationItem.title = ""
        pdfContractVC.contract = listContracts[indexPath.row]
        self.navigationController?.pushViewController(pdfContractVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            indicator.isHidden = false
            indicator.startAnimating()
            let contract : Contract = listContracts[indexPath.row]
            let dictionary : [String: Any] = ["id":contract.id!]
            self.listContracts.remove(at: indexPath.row)
            self.table.reloadData()
            ContractService.deleteContract(VC: self, jsonParams: dictionary) { (result) in
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

extension ContractsViewController : ContractDelegate {
    
    func deleteContract(contract: Contract) {
        print("deleteContract")
        listContracts.removeAll(where: {$0.id == contract.id})
        table.reloadData()
    }
    
    func addContract(contract: Contract) {
        print("addContract")
        listContracts.append(contract)
        table.reloadData()
    }
    
    func updateContract(contract: Contract) {
        print("updateContract")
        table.reloadData()
    }
    
    
}
