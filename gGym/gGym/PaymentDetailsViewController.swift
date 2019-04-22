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
    @IBOutlet weak var clientsField: UIPickerView!    
    @IBOutlet weak var amountField: UILabel!
    @IBOutlet weak var amountDateField: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Save button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Guardar", style: .plain, target: self, action: #selector(PaymentDetailsViewController.saveButtonTapped))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
