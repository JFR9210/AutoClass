//
//  ViewController.swift
//  AutoClass
//
//  Created by Jonathan Fajardo Roa on 5/8/19.
//  Copyright © 2019 JFR. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    var listOptions : [String] = ["CLIENTES", "MARCAS", "AUTOS", "CONTRATOS"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationItem.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
    }

    //TABLEVIEW
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let lblOption : UILabel = cell.viewWithTag(1) as! UILabel
        
        lblOption.text = listOptions[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "clientsVC") as! ClientsViewController
            self.navigationController?.pushViewController(VC, animated: true)
        } else if indexPath.row == 1 {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "brandsVC") as! BrandsViewController
            self.navigationController?.pushViewController(VC, animated: true)
        } else if indexPath.row == 2 {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "carsVC") as! CarsViewController
            self.navigationController?.pushViewController(VC, animated: true)
        } else if indexPath.row == 3 {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "contractsVC") as! ContractsViewController
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}

