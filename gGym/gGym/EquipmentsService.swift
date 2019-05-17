//
//  EquipmentsService.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 02/05/2019.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import Foundation

class EquipmentsService {
    
    // Call to the Backend service for getting the equipments of a Center
    class func getEquipmentsForCenter(centerId: CLong, userId: CLong) -> [Equipment] {
        // List of equipments to be returned
        var equipments = [Equipment]()
        // Semaphore for controlling execution
        let semaphore = DispatchSemaphore(value: 0)
        // Build HTTP Request
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.url = URL(string: Constants.apiHost + Constants.equipmentsPath + "/centro/" + String(centerId))
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        // Request headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(String(userId), forHTTPHeaderField: "idUsuario")
        // Send request
        let dataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {data, response, error in
            // Get the HTTP Response
            let httpResponse = response as? HTTPURLResponse
            // Return true or false
            if httpResponse?.statusCode == 200{
                do {
                    // parse the JSON file
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)  as? NSArray
                    // Get the information from the array of objects
                    for equipmentJSON in json! {
                        // Covert to a dictionary
                        let dictionary = equipmentJSON as! NSDictionary
                        // Do recover the equipment information
                        let equipment = Equipment(idEquipamiento: dictionary["idEquipamiento"] as! CLong, idCentroDeportivo: dictionary["idCentroDeportivo"] as! CLong, nombreEquipamiento: dictionary["nombreEquipamiento"] as! String, descripcionEquipamiento: dictionary["descripcionEquipamiento"] as! String)
                        // Do recover reservation information for this operation
                        let reservations = dictionary["reservas"]  as? NSArray
                        // Get the information from the array of objects
                        for reservation in reservations! {
                            // Covert to a dictionary
                            let resDictionary = reservation as! NSDictionary
                            // Date formatter for parsing dates
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                            let reservaDesdeStr = resDictionary["reservaDesde"] as! String
                            let reservaHastaStr = resDictionary["reservaHasta"] as! String
                            // Do recover the reservation information
                            let reservationJSON = Reservation(idEquipamiento: resDictionary["idEquipamiento"] as! CLong, idReserva: resDictionary["idReserva"] as! CLong, idAbonado: resDictionary["idAbonado"] as! CLong, reservaDesde: dateFormatter.date(from: reservaDesdeStr)!, reservaHasta: dateFormatter.date(from: reservaHastaStr)!)
                            // Append reservation to the equipment object
                            equipment?.reservas.append(reservationJSON!)
                        }
                        // Append to the array
                        equipments.append(equipment!)
                    }
                } catch let parseError as NSError {
                    print("JSON Error \(parseError.localizedDescription)")
                }
            }
            // End semaphore
            semaphore.signal()
        })
        // Execute and wait
        dataTask.resume()
        semaphore.wait()
        // Return the result
        return equipments
    }
    
    // Call to the Backend service for creating a new equipment
    class func createEquipment(idUser: CLong, equipment: Equipment) -> Bool {
        // Result of the call
        var result = false
        // Semaphore for controlling execution
        let semaphore = DispatchSemaphore(value: 0)
        // Build HTTP Request
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.url = URL(string: Constants.apiHost + Constants.equipmentsPath + "/crear")
        request.httpMethod = "POST"
        request.timeoutInterval = 30
        request.httpBody = equipment.jsonRepresentation
        // Request headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(String(idUser), forHTTPHeaderField: "idUsuario")
        // Send request
        let dataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {data, response, error in
            // Get the HTTP Response
            let httpResponse = response as? HTTPURLResponse
            // Return true or false
            if httpResponse?.statusCode == 200{
                result = true
            }
            // End semaphore
            semaphore.signal()
        })
        // Execute and wait
        dataTask.resume()
        semaphore.wait()
        // Return the result
        return result
    }

}
