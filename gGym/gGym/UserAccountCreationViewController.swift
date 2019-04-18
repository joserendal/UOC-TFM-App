//
//  UserAccountCreationViewController.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 13/4/19.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import UIKit

class UserAccountCreationViewController : UIViewController {
    
    // UIViewController - Segment and Views
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var personalDataViewContainer: UIView!
    @IBOutlet weak var centerDataViewContainer: UIView!
    
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
    
    // Configure navigation bar
    override func viewWillAppear(_ animated: Bool) {
        // View title
        navigationItem.title = "Crear una cuenta"
        // Create button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Crear", style: .plain, target: self, action: #selector(UserAccountCreationViewController.createButtonTapped))
        // Segment control initial state
        personalDataViewContainer.isHidden = false
        centerDataViewContainer.isHidden = true
    }
    
    func createButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // User clicks in Segment change
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        // Get the index clicked
        let index = sender.selectedSegmentIndex
        // swith views according to the index
        switch index {
        case 1:
            personalDataViewContainer.isHidden = true
            centerDataViewContainer.isHidden = false
        default:
            personalDataViewContainer.isHidden = false
            centerDataViewContainer.isHidden = true
        }
    }
}
