//
//  UserAccountCreationViewController.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 13/4/19.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import UIKit

class UserAccountCreationViewController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Progressbar
    let progressBar = DialogHelper(text: "Enviando datos, espere por favor...")
    
    // UIViewController - Segment and Views
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var personalDataViewContainer: UIView!
    @IBOutlet weak var centerDataViewContainer: UIView!
    @IBOutlet weak var userAccountView: UIView!
    
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
    
    // User data
    @IBOutlet weak var userEmailField: UITextField!
    @IBOutlet weak var userPassword1Field: UITextField!
    @IBOutlet weak var userPassword2Field: UITextField!
    
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
        userAccountView.isHidden = true
    }
    
    // Configure view once it has appeared
    override func viewDidLoad() {
        super.viewDidLoad()
        // Clean delegate
        centerTypeField.delegate = self
        centerTypeField.dataSource = self
        // Append loading dialog
        progressBar.hide()
        self.view.addSubview(progressBar)
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
            userAccountView.isHidden = true
        case 2:
            personalDataViewContainer.isHidden = true
            centerDataViewContainer.isHidden = true
            userAccountView.isHidden = false
        default:
            personalDataViewContainer.isHidden = false
            centerDataViewContainer.isHidden = true
            userAccountView.isHidden = true
        }
    }
    
    
    
    
    // ---- ACTIONS ----
    // Action 1. Create account
    @IBAction func createButtonTapped(_ sender: Any) {
        // Show loading dialog
        progressBar.show()
        // If form doesn't get validated, return
        if !validateForm() {
            progressBar.hide()
            return
        }
        // Create the user object
        var user = User(nombre: nameField.text!, apellidos: surnameField.text!, fechaNacimiento: bornDateField.date, pais: stateField.text!)
        if(zipCodeFeld != nil) {
            user?.codigoPostal = Int(zipCodeFeld.text!)!
        }
        if(cityField != nil) {
            user?.ciudad = cityField.text!
        }
        if(provinceField != nil) {
            user?.provincia = provinceField.text!
        }
        // Call the user API
        user = UsuariosService.createUser(user: user)
        // Check if there was an error creating the user
        if(user?.idUsuario == 0) {
            DialogHelper.displayErrorDialogWithoutAction(title: "Error", message: "Hubo un error creando sus credenciales. Intentelo de nuevo mas tarde.", button: "Cerrar", callerController: self)
            progressBar.hide()
            return
        }
        // Create credentials object
        var credentials = Credentials(idUsuario: (user?.idUsuario)!, email: userEmailField.text!, password: userPassword1Field.text!)
        credentials = CredentialsService.createCredentials(credentials: credentials)
        // Check if there was an error creating the credentials
        if(credentials?.idUsuario == 0) {
            DialogHelper.displayErrorDialogWithoutAction(title: "Error", message: "Hubo un error creando sus credenciales. Intentelo de nuevo mas tarde.", button: "Cerrar", callerController: self)
            progressBar.hide()
            return
        }
        // Create center object
        var center = Center(idGestor: (user?.idUsuario)!, nombreCentro: centerNameField.text!, tipoCentro: centerTypes[centerTypeField.selectedRow(inComponent: 0)], direccion: centerAddressField.text!, ciudad: centerCityField.text!, provincia: centerProvinceField.text!, pais: centerCountryField.text!, codigoPostal: centerZipCodeField.text!, privado: !publicCenterField.isOn, numeroTelefono: centerPhoneNumberField.text!, emailContacto: centerEmailField.text!)
        center = CenterService.createCenters(center: center, idUsuario: 2)
        if(center?.idCentro == 0) {
            DialogHelper.displayErrorDialogWithoutAction(title: "Error", message: "Hubo un error creando su usuario. Intentelo de nuevo mas tarde.", button: "Cerrar", callerController: self)
            progressBar.hide()
            return
        }
        // Save the credentials object in the database
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: credentials!)
        let userDefaults: UserDefaults = UserDefaults.standard
        userDefaults.set(encodedData, forKey: "credentials")
        userDefaults.synchronize()
        // Stop progress bar
        progressBar.hide()
        // Hide view
        self.navigationController?.popViewController(animated: true)

    }
    
    // Action 2. Cancel account creation
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // ---- FUNCTIONS ----
    // Auxiliary function for validating the form before submitting it
    func validateForm() -> Bool {
        // 1. All required fields are present
        // User data fields
        let userFieldsValidation =
        FormValidator.validateRequiredTextFieldAndDisplayAlert(textField: nameField, fieldName: "Nombre del usuario", callerController: self) &&
        FormValidator.validateRequiredTextFieldAndDisplayAlert(textField: surnameField, fieldName: "Apellidos del usuario", callerController: self) &&
        FormValidator.validateRequiredTextFieldAndDisplayAlert(textField: stateField, fieldName: "País del usuario", callerController: self) &&
        // Center data fields
        FormValidator.validateRequiredTextFieldAndDisplayAlert(textField: centerNameField, fieldName: "Nombre del centro", callerController: self) &&
        FormValidator.validateRequiredTextFieldAndDisplayAlert(textField: centerAddressField, fieldName: "Dirección del centro", callerController: self) &&
        FormValidator.validateRequiredTextFieldAndDisplayAlert(textField: centerCityField, fieldName: "Ciudad del centro", callerController: self) &&
        FormValidator.validateRequiredTextFieldAndDisplayAlert(textField: centerProvinceField, fieldName: "Provincia del centro", callerController: self) &&
        FormValidator.validateRequiredTextFieldAndDisplayAlert(textField: centerCountryField, fieldName: "País del centro", callerController: self) &&
        FormValidator.validateRequiredTextFieldAndDisplayAlert(textField: centerZipCodeField, fieldName: "Código postal del centro", callerController: self) &&
        FormValidator.validateRequiredTextFieldAndDisplayAlert(textField: centerPhoneNumberField, fieldName: "Teléfono del centro", callerController: self) &&
        FormValidator.validateRequiredTextFieldAndDisplayAlert(textField: centerEmailField, fieldName: "Email del centro", callerController: self) &&
        // User data
        FormValidator.validateRequiredTextFieldAndDisplayAlert(textField: userEmailField, fieldName: "Email del usuario", callerController: self) &&
        FormValidator.validateRequiredTextFieldAndDisplayAlert(textField: userPassword1Field, fieldName: "Contraseña del usuario", callerController: self) &&
        FormValidator.validateRequiredTextFieldAndDisplayAlert(textField: userPassword2Field, fieldName: "Repetir contraseña del usuario", callerController: self)
        
        // 2. Email field is valid
        let emailValidation = FormValidator.validateEmailAddressAndDisplayAlert(textField: userEmailField, callerController: self)
        
        // 3. Passwords are equal
        let passwordsEqual = (userPassword1Field.text == userPassword2Field.text)
        if !passwordsEqual {
            DialogHelper.displayErrorDialogWithoutAction(title: "Error", message: "Las passwords no coinciden", button: "Cerrar", callerController: self)
        }
        
        
        // Return validation result
        return userFieldsValidation && emailValidation && passwordsEqual
    }
}
