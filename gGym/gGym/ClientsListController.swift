//
//  ClientsListController.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 21/4/19.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import UIKit

class ClientsListControllers: UITableViewController {
    
    // Data to be displayed in the screen
    var clients: [Client] = []
    // Dictionary with first letter
    var wordsDictionary = [String:[String]]()
    var wordsSection = [String]()
    
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
        // Get the center of the user
        let center = CenterService.getCenter(idUsuario: userId)
        // Get the list of clients from the backend
        clients = ClientsService.getClientsCenter(idCenter: center.idCentro, idUser: userId)
        // Do generate the index
        generateWordsDictionary()
    }
    
    // ---- TABLE MANAGEMENT ----
    override func numberOfSections(in tableView: UITableView) -> Int {
        return wordsSection.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return wordsSection[section]
    }
    
    override func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        let wordKey = wordsSection[section]
        if let wordValues = wordsDictionary[wordKey] {
            return wordValues.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "clientCell")!
        let wordKey = wordsSection[indexPath.section]
        if let wordValues = wordsDictionary[wordKey] {
            cell.textLabel?.text  = wordValues[indexPath.row]
        }
        
        return cell
    }
    
    func generateWordsDictionary() {
        for client in clients {
            // Do extract the key of the dictionary
            let key = "\(client.apellidos[client.apellidos.startIndex])"
            
            // check if already in the dictionary
            if var values = wordsDictionary[key] {
                values.append(client.apellidos)
                wordsDictionary[key] = values
            } else {
                wordsDictionary[key] = [client.apellidos + ", " + client.nombre]
            }
        }
        // Sort the index list
        wordsSection = [String](wordsDictionary.keys)
        wordsSection = wordsSection.sorted()
    }
    
    
    // ---- ACTIONS ----
    // Action 1. Create Client
    @IBAction func createButtonTapped(_ sender: Any) {
    
    }
}
