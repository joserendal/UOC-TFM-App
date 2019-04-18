//
//  Credentials.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 13/4/19.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import Foundation

class Credentials: NSObject, NSCoding {
    
    var idUsuario: CLong
    var email: String
    var password: String
    
    init?(idUsuario: CLong, email: String, password: String) {
        
        // Initialization breaks up with null parameters
        if (email.isEmpty || password.isEmpty)  {
            return nil
        }
        
        // Initialize stored properties.
        self.idUsuario = idUsuario
        self.email = email
        self.password = password
    }
    
    var jsonRepresentation : Data {
        let dict = ["email" : email, "password" : password]
        return try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
    }
    
    func encode(with aCoder: NSCoder) {
        //add code here
        aCoder.encode(email, forKey: "email")
        aCoder.encode(password, forKey: "password")
        aCoder.encode(idUsuario, forKey: "idUsuario")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let email = aDecoder.decodeObject(forKey: "email") as! String
        let password = aDecoder.decodeObject(forKey: "password") as! String
        var idUsuario = 0
        if (aDecoder.decodeObject(forKey: "idUsuario") != nil) {
            idUsuario = aDecoder.decodeObject(forKey: "idUsuario") as! CLong
        }
        self.init(idUsuario: idUsuario, email: email, password: password)
    }
    
}
