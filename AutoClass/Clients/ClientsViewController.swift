//
//  ClientsViewController.swift
//  AutoClass
//
//  Created by Jonathan Fajardo Roa on 5/9/19.
//  Copyright © 2019 JFR. All rights reserved.
//

import UIKit

class ClientsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var contract : Contract!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var table: UITableView!
    var listClients : [Client] = []
    var delegate : ClientDelegate!
    
    @IBOutlet weak var btnNew: UIButton!
    @IBAction func new(_ sender: Any) {
        
        let newClientVC = self.storyboard?.instantiateViewController(withIdentifier: "newClientVC") as! NewClientViewController
        self.navigationItem.title = ""
        newClientVC.delegate = delegate
        self.navigationController?.pushViewController(newClientVC, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        table.delegate = self
        table.dataSource = self
        
        delegate = self
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "CLIENTES"
        
        loadData()
        
    }
    
    func loadData(){
        indicator.isHidden = false
        indicator.startAnimating()
        ClientService.getClients(VC: self) { (list) in
            self.indicator.isHidden = true
            self.indicator.stopAnimating()
            self.listClients = list
            self.table.reloadData()
        }
    }
    
    //TABLEVIEW
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listClients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let client = listClients[indexPath.row]
        
        let lblOption : UILabel = cell.viewWithTag(1) as! UILabel
        
        lblOption.text = client.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if contract != nil {
            
            contract.client = listClients[indexPath.row]
            self.navigationController?.popViewController(animated: true)
            
        } else {
            
            let newClientVC = self.storyboard?.instantiateViewController(withIdentifier: "newClientVC") as! NewClientViewController
            self.navigationItem.title = ""
            newClientVC.delegate = delegate
            newClientVC.client = listClients[indexPath.row]
            self.navigationController?.pushViewController(newClientVC, animated: true)
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            indicator.isHidden = false
            indicator.startAnimating()
            let client : Client = listClients[indexPath.row]
            let dictionary : [String: Any] = ["rut":client.rut!]
            self.listClients.remove(at: indexPath.row)
            self.table.reloadData()
            ClientService.deleteClient(VC: self, jsonParams: dictionary) { (result) in
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

extension ClientsViewController : ClientDelegate {
    
    func getClients(clients: [Client]) {
        print("getClients")
    }
    
    func getClient(client: Client) {
        print("getClient")
    }
    
    func deleteClient(client: Client) {
        print("deleteClient")
        listClients.removeAll(where: {$0.id == client.id})
        table.reloadData()
    }
    
    func addClient(client: Client) {
        print("addClient")
        listClients.append(client)
        table.reloadData()
    }
    
    func updateClient(client: Client) {
        print("updateClient")
        table.reloadData()
    }
    
    
}
