//
//  CenterService.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 18/4/19.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import Foundation

class CenterService {
    
    // Call to the Backend service for creating the User
    class func createCenters(center: Center!, idUsuario: CLong) -> Center {
        // Semaphore for controlling execution
        let semaphore = DispatchSemaphore(value: 0)
        // Build HTTP Request
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.url = URL(string: Constants.apiHost + Constants.centrosPath + "/crear")
        request.httpMethod = "POST"
        request.timeoutInterval = 30
        // Request headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(String(idUsuario), forHTTPHeaderField: "idUsuario")
        // Request body
        request.httpBody = center.jsonRepresentation
        // Send request
        let dataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {data, response, error in
            // Get the HTTP Response
            let httpResponse = response as? HTTPURLResponse
            // Return true or false
            if httpResponse?.statusCode == 200{
                do {
                    // get the user ID
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)  as! [String:Any]
                    center.idCentro = json["idCentro"] as! CLong
                } catch let parseError as NSError {
                    print("JSON Error \(parseError.localizedDescription)")
                }
            } else {
                center.idCentro = 0
            }
            // End semaphore
            semaphore.signal()
        })
        // Execute and wait
        dataTask.resume()
        semaphore.wait()
        // Return the result
        return center
    }
}
