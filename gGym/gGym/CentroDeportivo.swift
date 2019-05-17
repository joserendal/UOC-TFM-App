//
//  CentroDeportivo.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 18/4/19.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import Foundation

class Center {
    
    var idCentro: CLong
    var idGestor: CLong
    var nombreCentro: String
    var tipoCentro: String
    var direccion: Date
    var ciudad: Int
    var provincia: String
    var pais: String
    var codigoPostal: String
    var privado: Bool
    var numeroTelefono: String
    var emailContacto: String
    
    init?(nombreCentro: String, tipoCentro: String, direccion: Date, ciudad: Int,
          provincia: String, pais: String, codigoPostal: String, privado: Bool,
          numeroTelefono: String, emailContacto: String) {
        // Initialize stored properties.
        self.idCentro = 0
        self.idGestor = 0
        self.nombreCentro = nombreCentro
        self.tipoCentro = tipoCentro
        self.direccion = direccion
        self.ciudad = ciudad
        self.provincia = provincia
        self.pais = pais
        self.codigoPostal = codigoPostal
        self.privado = privado
        self.numeroTelefono = numeroTelefono
        self.emailContacto = emailContacto
    }
    
    var jsonRepresentation : Data {
        let dict = ["nombreCentro" : nombreCentro,
                    "tipoCentro" : tipoCentro,
                    "direccion" : direccion,
                    "ciudad" : ciudad,
                    "provincia" : provincia,
                    "pais" : pais,
                    "codigoPostal" : codigoPostal,
                    "privado" : privado,
                    "numeroTelefono" : numeroTelefono,
                    "emailContacto" : emailContacto] as [String : Any]
        return try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
    }
    
}
