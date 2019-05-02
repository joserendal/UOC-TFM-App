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
    @IBOutlet weak var lastReservationsField: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        // Recover user information
        let userDefaults: UserDefaults = UserDefaults.standard
        if let data = userDefaults.object(forKey: "credentials") {
            let credentials = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as? Credentials
            userId = (credentials?.idUsuario)!
        }
        if(receivedEquipment == nil) {
            // Create button
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Guardar", style: .plain, target: self, action: #selector(EquipmentDetailsViewController.saveButtonTapped))
        }
        // In the case we have received any equipment, present it on the screen
        else if(receivedEquipment != nil) {
            // Create button
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reservar", style: .plain, target: self, action: #selector(EquipmentDetailsViewController.reservarButtonTapped))
            // Print equipment name information
            equipmentNameField.text = receivedEquipment?.nombreEquipamiento
            equipmentNameField.isEnabled = false
            // Print equipment description field
            equipmentDescriptionField.text = receivedEquipment?.descripcionEquipamiento
            equipmentDescriptionField.isEnabled = false
            // Print reservations for today
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            lastReservationsField.text = ""
            // Iterate through list of reservations
            for reservation in receivedEquipment!.reservas {
                // Build entry info
                let reservationHours = dateFormatter.string(from: reservation.reservaDesde) + " - " + dateFormatter.string(from: reservation.reservaHasta)
                // Get the information about the user of this reservation
                let client = ClientsService.getClientInformation(idClient: reservation.idAbonado, idUser: userId!)
                let clientInfo = reservationHours + ": " + client.apellidos + ", " + client.nombre
                // Append entry to the text box
                lastReservationsField.text =  lastReservationsField.text! + clientInfo + "\n"
            }
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
    
    // Action 2. Reservar button tapped
    @IBAction func reservarButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "presentReservationSegue", sender: receivedEquipment)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentReservationSegue" {
            let detailController = segue.destination as! ReservationViewController
            detailController.receivedEquipment = (sender as! Equipment)
        }
    }
}
