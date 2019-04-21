//
//  ClientsListController.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 21/4/19.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import Foundation
import UIKit

class ClientsListControllers: UITableViewController {
    
    // Configure view before appearing
    override func viewWillAppear(_ animated: Bool) {
        // Create button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Crear", style: .plain, target: self, action: #selector(UserAccountCreationViewController.createButtonTapped))
        // Recover user information
        var userId = 0
        let userDefaults: UserDefaults = UserDefaults.standard
        if let data = userDefaults.object(forKey: "credentials") {
            let credentials = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as? Credentials
            userId = (credentials?.idUsuario)!
        }
        // Get the list of clients from the backend
        let clients = ClientsService.getClientsCenter(idCenter: 1, idUser: userId)
    }
 
    // ---- ACTIONS ----
    // Action 1. Create Client
    @IBAction func createButtonTapped(_ sender: Any) {
    
    }
}
