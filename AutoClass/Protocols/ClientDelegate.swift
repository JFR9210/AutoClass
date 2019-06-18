//
//  clientDelegate.swift
//  AutoClass
//
//  Created by Jonathan Fajardo Roa on 5/8/19.
//  Copyright © 2019 JFR. All rights reserved.
//

import Foundation

protocol ClientDelegate: NSObjectProtocol {
    func getClients(clients: [Client])
    func getClient(client: Client)
    func deleteClient(client: Client)
    func addClient(client: Client)
    func updateClient(client: Client)
}
