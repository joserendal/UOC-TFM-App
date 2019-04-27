//
//  PaymentsViewController.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 22/4/19.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import UIKit

class PaymentsViewController: UITableViewController, DateSelectionCustomDelegate {

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
    // Month and Year to be displayed
    var month: Int?
    var year: Int?
    
    // Configure view before appearing
    override func viewWillAppear(_ animated: Bool) {
        // Set the segment clicked
        segmentController.selectedSegmentIndex = 0
        // get the current date and month if not selected previously
        if month == nil {
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy"
            year = Int(formatter.string(from: date))
            formatter.dateFormat = "MM"
            month = Int(formatter.string(from: date))
        }
        // Create button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sel. Fechas", style: .plain, target: self, action: #selector(PaymentsViewController.selectDateTapped))
        // Navigation title
        navigationItem.title = "Abonos " + String(describing: month!) + "/" + String(describing: year!)
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
        payments = PaymentsService.getPaidPayments(idCenter: centerId!, idUser: userId!, month: month!, year: year!)
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
            payments = PaymentsService.getPendingPayments(idCenter: centerId!, idUser: userId!, month: month!, year: year!)
            // Do generate the index
            generateWordsDictionary()
            // Force data reloading
            self.tableView.reloadData()
        default:
            // Load unpaid payments
            payments = PaymentsService.getPaidPayments(idCenter: centerId!, idUser: userId!, month: month!, year: year!)
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
    // User clicked in a row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(segmentController.selectedSegmentIndex == 1) {
            // Get the selected client
            let wordKey = wordsSection[indexPath.section]
            if let wordValues = wordsDictionary[wordKey] {
                let selectedClient = wordValues[indexPath.row]
                self.performSegue(withIdentifier: "paymentDetailsSegue", sender: selectedClient)
            }
        }
    }
    
    // Select date tapped. Display date modal segue.
    @IBAction func selectDateTapped(_ sender: Any) {
        let dateSelectionModalDialog = storyboard!.instantiateViewController(withIdentifier: "dateSelectionModalDialog") as! DateSelectionPopupController
        dateSelectionModalDialog.customDelegateForDataReturn = self
        dateSelectionModalDialog.receivedYear = year
        dateSelectionModalDialog.receivedMonth = month
        present(dateSelectionModalDialog, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "paymentDetailsSegue" {
            let detailController = segue.destination as! PaymentDetailsViewController
            detailController.client = (sender as! Client)
            detailController.month = month
            detailController.year = year
        }
    }
    
    // ---- DATA RECEIVED FROM MODAL DIALOG ----
    func sendDataBackToHomePageViewController(month: Int?, year: Int?) {
        self.month = month
        self.year = year
    }
}
