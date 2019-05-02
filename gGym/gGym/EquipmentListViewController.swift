//
//  EquipmentListViewController.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 02/05/2019.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import UIKit

class EquipmentListViewController: UITableViewController {
    
    // Data to be displayed in the screen
    var equipments: [Equipment] = []
    // Data needed to recover information from backnd
    var userId: CLong?
    var centerId: CLong?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Create button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Crear", style: .plain, target: self, action: #selector(EquipmentListViewController.createButtonTapped))
        // Recover user information
        var userId = 0
        let userDefaults: UserDefaults = UserDefaults.standard
        if let data = userDefaults.object(forKey: "credentials") {
            let credentials = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as? Credentials
            userId = (credentials?.idUsuario)!
        }
        // Get the center of the user
        let center = CenterService.getCenter(idUsuario: userId)
        // Get the list of equipments from the backend
        equipments = EquipmentsService.getEquipmentsForCenter(centerId: center.idCentro, userId: userId)
        // Force data reloading
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // we are only having one section
        return 1
    }
    
    override func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        // we are having N entries
        return equipments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "equipmentCell")!
        cell.textLabel?.text = equipments[indexPath.row].nombreEquipamiento
        cell.detailTextLabel?.text = equipments[indexPath.row].descripcionEquipamiento
        return cell
    }
    
    // ---- ACTIONS ----
    // Action 1. Create Client button tapped
    @IBAction func createButtonTapped(_ sender: Any) {
        // Send the user to the Main Menu
        //self.performSegue(withIdentifier: "createClientSegue", sender: self)
    }

}
