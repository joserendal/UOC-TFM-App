//
//  User.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 18/4/19.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import Foundation

class User: NSObject {
    
    var idUsuario: CLong
    var nombre: String
    var apellidos: String
    var fechaNacimiento: Date
    var codigoPostal: Int
    var ciudad: String
    var provincia: String
    var pais: String
    
    init?(nombre: String, apellidos: String, fechaNacimiento: Date, pais: String) {
        // Initialize stored properties.
        self.idUsuario = 0
        self.nombre = nombre
        self.apellidos = apellidos
        self.fechaNacimiento = fechaNacimiento
        self.codigoPostal = 0
        self.ciudad = ""
        self.provincia = ""
        self.pais = pais        
    }
    
    var jsonRepresentation : Data {
        // Date formatter
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        // Build dictionary
        let dict = ["nombre" : nombre,
                    "apellidos" : apellidos,
                    "fechaNacimiento" : dateformatter.string(from: fechaNacimiento),
                    "codigoPostal" : codigoPostal,
                    "ciudad" : ciudad,
                    "provincia" : provincia,
                    "pais" : pais] as [String : Any]
        return try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
    }
}
