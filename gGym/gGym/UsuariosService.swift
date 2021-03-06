//
//  UsuariosService.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 18/4/19.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import Foundation

class UsuariosService {
    
    // Call to the Backend service for creating the User
    class func createUser(user: User!) -> User {
        // Semaphore for controlling execution
        let semaphore = DispatchSemaphore(value: 0)
        // Build HTTP Request
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.url = URL(string: Constants.apiHost + Constants.usuariosPath + "/crear")
        request.httpMethod = "POST"
        request.timeoutInterval = 30
        // Request headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // Request body
        request.httpBody = user.jsonRepresentation
        // Send request
        let dataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {data, response, error in
            // Get the HTTP Response
            let httpResponse = response as? HTTPURLResponse
            // Return true or false
            if httpResponse?.statusCode == 200{
                do {
                    // get the user ID
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)  as! [String:Any]
                    user.idUsuario = json["idUsuario"] as! CLong
                } catch let parseError as NSError {
                        print("JSON Error \(parseError.localizedDescription)")
                }
            } else {
                user.idUsuario = 0
            }
            // End semaphore
            semaphore.signal()
        })
        // Execute and wait
        dataTask.resume()
        semaphore.wait()
        // Return the result
        return user
    }
}
