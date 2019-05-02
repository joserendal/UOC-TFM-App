//
//  ReservationViewController.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 02/05/2019.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import UIKit

class ReservationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Object
    var receivedEquipment: Equipment?
    var userId: CLong?
    var clientes: [Client]?
    // Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var abonadoPickerLabel: UIPickerView!
    @IBOutlet weak var fromDatePicker: UIDatePicker!
    @IBOutlet weak var toDatePicker: UIDatePicker!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        // Recover user information
        let userDefaults: UserDefaults = UserDefaults.standard
        if let data = userDefaults.object(forKey: "credentials") {
            let credentials = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as? Credentials
            userId = (credentials?.idUsuario)!
        }
        // Get the center of the user
        let center = CenterService.getCenter(idUsuario: userId!)
        // Recover list of clients of this center
        clientes = ClientsService.getClientsCenter(idCenter: center.idCentro, idUser: userId!)
        // Print additional info on the screen
        titleLabel.text = "Reservar " + receivedEquipment!.nombreEquipamiento
        // Save button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Guardar", style: .plain, target: self, action: #selector(ReservationViewController.saveButtonTapped))
    }
    
    // -- Picker configuration --
    // Configure view once it has appeared
    override func viewDidLoad() {
        super.viewDidLoad()
        // Clean delegate
        abonadoPickerLabel.delegate = self
        abonadoPickerLabel.dataSource = self
    }
    
    // Number of picker views in the view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Number of options to pick in the picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return clientes!.count
    }
    
    // Populate center types
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return clientes![row].apellidos + ", " + clientes![row].nombre
    }
    
    // -- Actions --
    @IBAction func saveButtonTapped(_ sender: Any) {
        // Get selected user
        let selectedClient = clientes![abonadoPickerLabel.selectedRow(inComponent: 0)]
        // Get the dates selected by the user
        let dateFrom = fromDatePicker.date
        let dateTo = toDatePicker.date
        // Build a reservation object
        let reservation = Reservation(idEquipamiento: receivedEquipment!.idEquipamiento, idReserva: 0, idAbonado: selectedClient.idAbonado, reservaDesde: dateFrom, reservaHasta: dateTo)
        // Add the reservation to the received equipment
        receivedEquipment?.reservas.append(reservation!)
        // Call backend service for creating the reservation
        let result = ReservationService.createEquipment(idUser: userId!, reservation: reservation!)
        if !result {
            // Do display an error message
            DialogHelper.displayErrorDialogWithoutAction(title: "Error", message: "No se ha podido registrar la reserva", button: "Cerrar", callerController: self)
        } else {
            // Do popup controller
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
