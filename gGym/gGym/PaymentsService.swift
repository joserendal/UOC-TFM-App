//
//  PaymentsService.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 22/4/19.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import Foundation

class PaymentsService {
    
    // Call to the Backend service for recovering pending payments
    class func getPendingPayments(idCenter: CLong, idUser: CLong, month: Int, year: Int) -> [Payment] {
        // List of payments to be returned
        var payments = [Payment]()
        // Semaphore for controlling execution
        let semaphore = DispatchSemaphore(value: 0)
        // Build HTTP Request
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.url = URL(string: Constants.apiHost + Constants.pagosPath + "/pendientes/" + String(idCenter) + "/" + String(month) + "/" + String(year))
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
                    for paymentJSON in json! {
                        // Covert to a dictionary
                        let dictionary = paymentJSON as! NSDictionary
                        // Do recover the client information
                        let clientInformation = dictionary["idAbonado"] as! NSDictionary
                        // Build the client information
                        // Do configure date formatter
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        // Build a client getting the values from the received JSON
                        let client = Client(nombre: clientInformation["nombre"] as! String, apellidos: clientInformation["apellidos"] as! String, direccion: "", ciudad: "", provincia: "", pais: "", codigoPostal: "", email: "", numeroTelefono: clientInformation["numeroTelefono"] as! String, fechaNacimiento: dateFormatter.date(from: clientInformation["fechaNacimiento"] as! String)!)
                        if clientInformation["direccion"] != nil {
                            client?.direccion = clientInformation["direccion"] as! String
                        }
                        if clientInformation["ciudad"] != nil {
                            client?.ciudad = clientInformation["ciudad"] as! String
                        }
                        if clientInformation["pais"] != nil {
                            client?.pais = clientInformation["pais"] as! String
                        }
                        if clientInformation["codigoPostal"] != nil {
                            client?.codigoPostal = clientInformation["codigoPostal"] as! String
                        }
                        if clientInformation["email"] != nil {
                            client?.email = clientInformation["email"] as! String
                        }
                        if clientInformation["idAbonado"] != nil {
                            client?.idAbonado = clientInformation["idAbonado"] as! CLong
                        }
                        if clientInformation["idCentroDeportivo"] != nil {
                            client?.idCentroDeportivo = clientInformation["idCentroDeportivo"] as! CLong
                        }
                        // Build the payment
                        let payment = Payment(idPagoAbonado: 0, idAbonado: client!, mes: dictionary["mes"] as! Int, anio: dictionary["anio"] as! Int)
                        // Append to the array
                        payments.append(payment!)
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
          return payments
    }
    
    // Call to the Backend service for recovering pending payments
    class func getPaidPayments(idCenter: CLong, idUser: CLong, month: Int, year: Int) -> [Payment] {
        // List of payments to be returned
        var payments = [Payment]()
        // Semaphore for controlling execution
        let semaphore = DispatchSemaphore(value: 0)
        // Build HTTP Request
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.url = URL(string: Constants.apiHost + Constants.pagosPath + "/abonados/" + String(idCenter) + "/" + String(month) + "/" + String(year))
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
                    for paymentJSON in json! {
                        // Covert to a dictionary
                        let dictionary = paymentJSON as! NSDictionary
                        // Do recover the client information
                        let clientInformation = dictionary["idAbonado"] as! NSDictionary
                        // Build the client information
                        // Do configure date formatter
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        // Build a client getting the values from the received JSON
                        let client = Client(nombre: clientInformation["nombre"] as! String, apellidos: clientInformation["apellidos"] as! String, direccion: "", ciudad: "", provincia: "", pais: "", codigoPostal: "", email: "", numeroTelefono: clientInformation["numeroTelefono"] as! String, fechaNacimiento: dateFormatter.date(from: clientInformation["fechaNacimiento"] as! String)!)
                        if clientInformation["direccion"] != nil {
                            client?.direccion = clientInformation["direccion"] as! String
                        }
                        if clientInformation["ciudad"] != nil {
                            client?.ciudad = clientInformation["ciudad"] as! String
                        }
                        if clientInformation["pais"] != nil {
                            client?.pais = clientInformation["pais"] as! String
                        }
                        if clientInformation["codigoPostal"] != nil {
                            client?.codigoPostal = clientInformation["codigoPostal"] as! String
                        }
                        if clientInformation["email"] != nil {
                            client?.email = clientInformation["email"] as! String
                        }
                        if clientInformation["idAbonado"] != nil {
                            client?.idAbonado = clientInformation["idAbonado"] as! CLong
                        }
                        if clientInformation["idCentroDeportivo"] != nil {
                            client?.idCentroDeportivo = clientInformation["idCentroDeportivo"] as! CLong
                        }
                        // Build the payment
                        let payment = Payment(idPagoAbonado: dictionary["idPagoAbonado"] as! CLong, idAbonado: client!, mes: dictionary["mes"] as! Int, anio: dictionary["anio"] as! Int)
                        // Append to the array
                        payments.append(payment!)
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
        return payments
    }
    
    // Call backend service for creating payments
    class func createPayment(idUser: CLong, payment: Payment) -> Bool {
        // Result of the call
        var result = false
        // Semaphore for controlling execution
        let semaphore = DispatchSemaphore(value: 0)
        // Build HTTP Request
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.url = URL(string: Constants.apiHost + Constants.pagosPath + "/crear")
        request.httpMethod = "POST"
        request.timeoutInterval = 30
        request.httpBody = payment.jsonRepresentation        
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
