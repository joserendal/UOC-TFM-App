//
//  UserAccountCreationViewController.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 13/4/19.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import UIKit

class UserAccountCreationViewController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
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
    let centerTypes = ["Gimnasio","Polideportivo","Centro de aventura", "Box de Crossfit", "Otros"]
    @IBOutlet weak var centerNameField: UITextField!
    @IBOutlet weak var centerTypeField: UIPickerView!
    @IBOutlet weak var centerAddressField: UITextField!
    @IBOutlet weak var centerCityField: UITextField!
    @IBOutlet weak var centerProvinceField: UITextField!
    @IBOutlet weak var centerCountryField: UITextField!
    @IBOutlet weak var centerZipCodeField: UITextField!
    @IBOutlet weak var publicCenterField: UISwitch!
    @IBOutlet weak var centerPhoneNumberField: UITextField!
    @IBOutlet weak var centerEmailField: UITextField!
    
    // ---- VIEW CONFIGURATION ----
    // Configure view before appearing
    override func viewWillAppear(_ animated: Bool) {
        // View title
        navigationItem.title = "Crear una cuenta"
        // Create button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Crear", style: .plain, target: self, action: #selector(UserAccountCreationViewController.createButtonTapped))
        // Segment control initial state
        personalDataViewContainer.isHidden = false
        centerDataViewContainer.isHidden = true
    }
    
    // Configure view once it has appeared
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centerTypeField.delegate = self
        centerTypeField.dataSource = self
    }
    
    // Number of picker views in the view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Number of options to pick in the picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return centerTypes.count
    }
    
    // Populate center types
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return centerTypes[row]
    }
    
    // ---- VIEW LISTENERS ----
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
    
    
    
    
    // ---- ACTIONS ----
    func createButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
