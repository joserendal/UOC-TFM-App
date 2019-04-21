//
//  ClientsService.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 21/4/19.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import Foundation

class ClientsService {
    
    // Call to the Backend service for creating the User
    class func getClientsCenter(idCenter: CLong, idUser: CLong) -> [Client] {
        // List of clients to be returned
        var clients = [Client]()
        // Semaphore for controlling execution
        let semaphore = DispatchSemaphore(value: 0)
        // Build HTTP Request
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.url = URL(string: Constants.apiHost + Constants.abonadosPath + "/centro/" + String(idCenter))
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        // Request headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(String(idUser), forHTTPHeaderField: "idUsuario")
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
                    for clientJSON in json! {
                        // Covert to a dictionary
                        let dictionary = clientJSON as! NSDictionary
                        // Do configure date formatter
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        // Build the client
                        let client = Client(nombre: dictionary["nombre"] as! String, apellidos: dictionary["apellidos"] as! String, direccion: dictionary["direccion"] as! String, ciudad: dictionary["ciudad"] as! String, provincia: dictionary["provincia"] as! String, pais: dictionary["pais"] as! String, codigoPostal: dictionary["codigoPostal"] as! String, email: dictionary["email"] as! String, numeroTelefono: dictionary["numeroTelefono"] as! String, fechaNacimiento: dateFormatter.date(from: dictionary["fechaNacimiento"] as! String)!)
                        client?.idCentroDeportivo = dictionary["idCentroDeportivo"] as! CLong
                        client?.idAbonado = dictionary["idAbonado"] as! CLong
                        // Append to the array
                        clients.append(client!)
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
        return clients
    }
    
    // Do update an existing client using the API
    class func updateClient(client: Client, idUser: CLong) -> Bool {
        var result = false
        // Semaphore for controlling execution
        let semaphore = DispatchSemaphore(value: 0)
        // Build HTTP Request
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.url = URL(string: Constants.apiHost + Constants.abonadosPath + "/actualizar")
        request.httpMethod = "PUT"
        request.timeoutInterval = 30
        // Request headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(String(idUser), forHTTPHeaderField: "idUsuario")
        // Request body
        request.httpBody = client.jsonRepresentation
        
        // Send request
        let dataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            // Get the HTTP Response
            let httpResponse = response as? HTTPURLResponse
            // Return true or false
            if httpResponse?.statusCode == 200{
                // Operation succeeded
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
