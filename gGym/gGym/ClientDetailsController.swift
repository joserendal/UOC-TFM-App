//
//  ClientDetailsController.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 21/4/19.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import UIKit

class ClientDetailsController: UIViewController {
    
    // Received client from table view
    var client: Client?
    
    // Outlets
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var apellidos: UITextField!
    @IBOutlet weak var direccion: UITextField!
    @IBOutlet weak var ciudad: UITextField!
    @IBOutlet weak var provincia: UITextField!
    @IBOutlet weak var pais: UITextField!
    @IBOutlet weak var numeroTelefono: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var fechaNacimiento: UIDatePicker!
    @IBOutlet weak var codigoPostal: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // if client is not null, present info on the screen
        if client != nil {
            nombre.text = client?.nombre
            apellidos.text = client?.apellidos
            fechaNacimiento.date = (client?.fechaNacimiento)!
            direccion.text = client?.direccion
            ciudad.text = client?.ciudad
            provincia.text = client?.provincia
            pais.text = client?.pais
            numeroTelefono.text = client?.numeroTelefono
            email.text = client?.email
            codigoPostal.text = client?.codigoPostal
        }
        // Add create button on tab bar
        // Create button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Guardar", style: .plain, target: self, action: #selector(ClientDetailsController.createButtonTapped))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // ---- ACTIONS ----
    @IBAction func createButtonTapped(_ sender: Any) {
        // Check if all required fields where introduced
        if !validateForm() {
            return
        }
        
        // Build a client getting the values from the ui
        var userClient = Client(nombre: nombre.text!, apellidos: apellidos.text!, direccion: direccion.text!, ciudad: ciudad.text!, provincia: provincia.text!, pais: pais.text!, codigoPostal: codigoPostal.text!, email: email.text!, numeroTelefono: numeroTelefono.text!, fechaNacimiento: fechaNacimiento.date)
        
        // if there is a client, call update method
        if client != nil {
            
            
        }
    }
    
    func validateForm() -> Bool {
        // 1. All required fields are present
        let requiredFields =
            FormValidator.validateRequiredTextFieldAndDisplayAlert(textField: nombre, fieldName: "Nombre del abonado", callerController: self) &&
            FormValidator.validateRequiredTextFieldAndDisplayAlert(textField: apellidos, fieldName: "Apellidos del abonado", callerController: self) &&
            FormValidator.validateRequiredTextFieldAndDisplayAlert(textField: numeroTelefono, fieldName: "Número de teléfono", callerController: self)
        // Check if date field is present
        if fechaNacimiento == nil {
            // Display validation error
            DialogHelper.displayErrorDialogWithoutAction(title: "Error", message: "El campo fecha de nacimiento es requerido", button: "Cerrar", callerController: self)
            // Validation not succeded
            return false
        }
        // Validation OK
        return requiredFields

    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
