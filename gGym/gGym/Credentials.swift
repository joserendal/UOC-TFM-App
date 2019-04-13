//
//  Credentials.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 13/4/19.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import Foundation

class Credentials {
    
    var email: String
    var password: String
    
    init?(email: String, password: String) {
        
        // Initialization breaks up with null parameters
        if (email.isEmpty || password.isEmpty)  {
            return nil
        }
        
        // Initialize stored properties.
        self.email = email
        self.password = password
    }
    
    var jsonRepresentation : Data {
        let dict = ["email" : email, "password" : password]
        return try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
    }
    
}
