//
//  EquipmentDetailsViewController.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 02/05/2019.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import UIKit

class EquipmentDetailsViewController: UIViewController {
    
    // Object
    var receivedEquipment: Equipment?
    var userId: CLong?
    // Outlets
    @IBOutlet weak var equipmentNameField: UITextField!
    @IBOutlet weak var equipmentDescriptionField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        // Create button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Guardar", style: .plain, target: self, action: #selector(EquipmentDetailsViewController.saveButtonTapped))
        // In the case we have received any equipment, present it on the screen
        if(receivedEquipment != nil) {
            equipmentNameField.text = receivedEquipment?.nombreEquipamiento
            equipmentDescriptionField.text = receivedEquipment?.descripcionEquipamiento
        }
        // Recover user information
        let userDefaults: UserDefaults = UserDefaults.standard
        if let data = userDefaults.object(forKey: "credentials") {
            let credentials = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as? Credentials
            userId = (credentials?.idUsuario)!
        }
    }
    
    // ---- ACTIONS ----
    // Action 1. Create Client button tapped
    @IBAction func saveButtonTapped(_ sender: Any) {
        if(receivedEquipment == nil) {
            // Get the center of the user
            let center = CenterService.getCenter(idUsuario: userId!)
            // Build a new Equipment from scratch
            let equipment = Equipment(idEquipamiento: 0, idCentroDeportivo: center.idCentro, nombreEquipamiento: equipmentNameField.text!, descripcionEquipamiento: equipmentDescriptionField.text!)
            // Call backend service for saving the new equipment
            let result = EquipmentsService.createEquipment(idUser: userId!, equipment: equipment!)
            // If successful result, go back to the previous screen
            if result {
                // Pop view controller
                self.navigationController?.popViewController(animated: true)
            } else {
                // Display error message
                DialogHelper.displayErrorDialogWithoutAction(title: "Error", message: "No se ha podido registrar el equipamiento", button: "Cerrar", callerController: self)
            }
        }
    }

}
