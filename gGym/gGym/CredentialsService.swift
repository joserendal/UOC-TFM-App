//
//  CredentialsService.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 13/4/19.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import Foundation

class CredentialsService {
    
    // Call to the Backend service for Authentication
    class func login(credentials: Credentials!) -> Bool {
        // Result
        var result: Bool!
        // Semaphore for controlling execution
        let semaphore = DispatchSemaphore(value: 0)
        // Build HTTP Request
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.url = URL(string: Constants.apiHost + Constants.credentialsPath + "/login")
        request.httpMethod = "POST"
        request.timeoutInterval = 30
        // Request headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // Request body
        request.httpBody = credentials.jsonRepresentation
        
        // Send request
        let dataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            // Get the HTTP Response
            let httpResponse = response as? HTTPURLResponse
            // Return true or false
            if httpResponse?.statusCode == 200{
                result = true
            } else {
                result = false
            }
            // End semaphore
            semaphore.signal()
        })
        // Execute and wait
        dataTask.resume()
        semaphore.wait()
        // Return the result
        return result;
    }
    
    
    // Call to the Backend service for credentials creation
    class func createCredentials(credentials: Credentials!) -> Credentials {
        // Semaphore for controlling execution
        let semaphore = DispatchSemaphore(value: 0)
        // Build HTTP Request
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.url = URL(string: Constants.apiHost + Constants.credentialsPath + "/crear")
        request.httpMethod = "POST"
        request.timeoutInterval = 30
        // Request headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // Request body
        request.httpBody = credentials.jsonRepresentation
        // Send request
        let dataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            // Get the HTTP Response
            let httpResponse = response as? HTTPURLResponse
            // Return true or false
            if httpResponse?.statusCode != 200{
                credentials.idUsuario = 0
            }
            // End semaphore
            semaphore.signal()
        })
        // Execute and wait
        dataTask.resume()
        semaphore.wait()
        // Return the result
        return credentials
    }
    
}
