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
        let dict = ["idUsuario": idUsuario, "email" : email, "password" : password] as [String : Any]
        return try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
    }
    
    func encode(with aCoder: NSCoder) {
        //add code here
        aCoder.encode(email, forKey: "email")
        aCoder.encode(password, forKey: "password")
        aCoder.encode(String(idUsuario), forKey: "idUsuario")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let email = aDecoder.decodeObject(forKey: "email") as! String
        let password = aDecoder.decodeObject(forKey: "password") as! String
        let idUsuario = aDecoder.decodeObject(forKey: "idUsuario") as! String
        self.init(idUsuario: CLong(idUsuario)!, email: email, password: password)
    }
    
}
