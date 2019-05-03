//
//  ReceiptsService.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 27/4/19.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import Foundation

class ReceiptsService {
    
    // Call to the Backend service for creating a new Receipt
    class func createReceipt(idUser: CLong, receipt: Receipt) -> Bool {
        // Result of the call
        var result = false
        // Semaphore for controlling execution
        let semaphore = DispatchSemaphore(value: 0)
        // Build HTTP Request
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.url = URL(string: Constants.apiHost + Constants.receiptsPath + "/crear")
        request.httpMethod = "POST"
        request.timeoutInterval = 30
        request.httpBody = receipt.jsonRepresentation
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
    
    // Call to the Backend service for getting the receipt asociated to a given user
    class func getReceiptForUser(idUser: CLong, idClient: CLong) -> Receipt {
        // List of payments to be returned
        let receipt = Receipt(idAbonado: idClient, importe: 0, periodicidad: "")
        // Semaphore for controlling execution
        let semaphore = DispatchSemaphore(value: 0)
        // Build HTTP Request
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.url = URL(string: Constants.apiHost + Constants.receiptsPath + "/" + String(idClient))
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
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)  as! [String:Any]
                    // Get the information from the JSON response
                    receipt?.importe = json["importe"] as! Double
                    receipt?.periodicidad = json["periodicidad"] as! String
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
        // Return the receipt
        return receipt!
    }
}
