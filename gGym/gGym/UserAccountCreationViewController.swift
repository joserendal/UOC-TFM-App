//
//  UserAccountCreationViewController.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 13/4/19.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import UIKit

class UserAccountCreationViewController : UIViewController {
    
    // UIViewController
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    // User data
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var bornDateField: UIDatePicker!
    @IBOutlet weak var zipCodeFeld: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var provinceField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    // Center data
    @IBOutlet weak var centerNameField: UITextField!
    @IBOutlet weak var tipeField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    
    // Configurar barra de navegación
    override func viewWillAppear(_ animated: Bool) {
        // View title
        navigationItem.title = "Crear una cuenta"
        // Create button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Crear", style: .plain, target: self, action: #selector(UserAccountCreationViewController.createButtonTapped))
        
    }
    
    func createButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
    }
}
