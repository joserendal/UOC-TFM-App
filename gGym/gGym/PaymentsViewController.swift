//
//  PaymentsViewController.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 22/4/19.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import UIKit

class PaymentsViewController: UITableViewController {

    // Segment controller
    @IBOutlet weak var segmentController: UISegmentedControl!
    // Data to be displayed in the screen
    var payments: [Payment] = []
    // Dictionary with first letter
    var wordsDictionary = [String:[Client]]()
    var wordsSection = [String]()
    // Received client from table view
    var userId: CLong?
    var centerId: CLong?
    
    // Configure view before appearing
    override func viewWillAppear(_ animated: Bool) {
        // Create button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Registrar Pago", style: .plain, target: self, action: #selector(PaymentsViewController.createButtonTapped))
        // Recover user information
        let userDefaults: UserDefaults = UserDefaults.standard
        if let data = userDefaults.object(forKey: "credentials") {
            let credentials = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as? Credentials
            userId = (credentials?.idUsuario)!
        }
        // Get the center of the user
        let center = CenterService.getCenter(idUsuario: userId!)
        centerId = center.idCentro
        // Get the list of payments from the backend
        payments = PaymentsService.getPaidPayments(idCenter: centerId!, idUser: userId!)
        // Do generate the index
        generateWordsDictionary()
        // Force data reloading
        self.tableView.reloadData()
    }
    
    // ---- VIEW LISTENERS ----
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        // Get the index clicked
        let index = sender.selectedSegmentIndex
        // swith views according to the index
        switch index {
        case 1:
            // Load paid payments
            payments = PaymentsService.getPendingPayments(idCenter: centerId!, idUser: userId!)
            // Do generate the index
            generateWordsDictionary()
            // Force data reloading
            self.tableView.reloadData()
        default:
            // Load unpaid payments
            payments = PaymentsService.getPaidPayments(idCenter: centerId!, idUser: userId!)
            // Do generate the index
            generateWordsDictionary()
            // Force data reloading
            self.tableView.reloadData()
        }
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
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "paymentCell")!
        let wordKey = wordsSection[indexPath.section]
        if let wordValues = wordsDictionary[wordKey] {
            cell.textLabel?.text  = wordValues[indexPath.row].apellidos + ", " + wordValues[indexPath.row].nombre
        }
        
        return cell
    }
    
    func generateWordsDictionary() {
        // Clean arrays
        wordsDictionary = [String:[Client]]()
        wordsSection = [String]()
        // Iterate through payments list
        for payment in payments {
            // Do extract the key of the dictionary
            let key = "\(payment.idAbonado.apellidos[payment.idAbonado.apellidos.startIndex])"
            
            // check if already in the dictionary
            if var values = wordsDictionary[key] {
                values.append(payment.idAbonado)
                wordsDictionary[key] = values
            } else {
                wordsDictionary[key] = [payment.idAbonado]
            }
        }
        // Sort the index list
        wordsSection = [String](wordsDictionary.keys)
        wordsSection = wordsSection.sorted()
    }
    
    
    // ---- ACTIONS ----
    // Action 1. Create Client button tapped
    @IBAction func createButtonTapped(_ sender: Any) {
        // Send the user to the Main Menu
        self.performSegue(withIdentifier: "createPaymentSegue", sender: self)
    }
    
    // User clicked in a row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get the selected client
        let wordKey = wordsSection[indexPath.section]
        if let wordValues = wordsDictionary[wordKey] {
            let selectedClient = wordValues[indexPath.row]
            self.performSegue(withIdentifier: "paymentDetailsSegue", sender: selectedClient)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "paymentDetailsSegue" {
            let detailController = segue.destination as! ClientDetailsController
            detailController.client = (sender as! Client)
        }
    }

}
