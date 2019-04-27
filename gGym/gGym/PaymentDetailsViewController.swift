//
//  PaymentDetailsViewController.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 22/4/19.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import UIKit

class PaymentDetailsViewController: UIViewController {
    
    // Received client from table view
    var client: Client?
    var userId: CLong?
    // Outlets
    @IBOutlet weak var clientField: UILabel!
    @IBOutlet weak var amountField: UILabel!
    @IBOutlet weak var amountDateField: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Save button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Guardar", style: .plain, target: self, action: #selector(PaymentDetailsViewController.saveButtonTapped))
        // Get the userid from the saved item
        let userDefaults: UserDefaults = UserDefaults.standard
        if let data = userDefaults.object(forKey: "credentials") {
            let credentials = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as? Credentials
            userId = (credentials?.idUsuario)!
        }
        // Print user information in the screen
        clientField.text = (client?.apellidos)! + ", " + (client?.nombre)!        
        // Recover the receipt for this user
        let receipt = ReceiptsService.getReceiptForUser(idUser: userId!, idClient: (client?.idAbonado)!)
        amountField.text = String(receipt.importe)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        // Get the selected date components
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: amountDateField.date)
        formatter.dateFormat = "MM"
        let month = formatter.string(from: amountDateField.date)
        // Call backend service for registering the payment
        let payment = Payment(idPagoAbonado: 0, idAbonado: client!, mes: Int(month)!, anio: Int(year)!)
        let result = PaymentsService.createPayment(idUser: userId!, payment: payment!)
        if !result {
            // Display validation error
            DialogHelper.displayErrorDialogWithoutAction(title: "Error", message: "No se ha podido registrar el pago", button: "Cerrar", callerController: self)
            // Return
            return
        }
        // Go back to the previous screen
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
