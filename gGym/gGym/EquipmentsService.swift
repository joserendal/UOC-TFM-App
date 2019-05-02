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

}
