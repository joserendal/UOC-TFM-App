//
//  Client.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 21/4/19.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import Foundation

class Client: NSObject {
    
    var idAbonado: CLong
    var idCentroDeportivo: CLong
    var nombre: String
    var apellidos: String
    var direccion: String
    var ciudad: String
    var provincia: String
    var pais: String
    var codigoPostal: String
    var email: String
    var numeroTelefono: String
    var fechaNacimiento: Date
    
    init?(nombre: String, apellidos: String, direccion: String, ciudad: String, provincia: String, pais: String, codigoPostal: String, email: String, numeroTelefono: String, fechaNacimiento: Date) {
        self.idAbonado = 0
        self.idCentroDeportivo = 0
        self.nombre = nombre
        self.apellidos = apellidos
        self.direccion = direccion
        self.ciudad = ciudad
        self.provincia = provincia
        self.pais = pais
        self.codigoPostal = codigoPostal
        self.email = email
        self.numeroTelefono = numeroTelefono
        self.fechaNacimiento = fechaNacimiento
    }
    
    var jsonRepresentation : Data {
        // Date formatter
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        // JSON dictionary
        let dict = ["idAbonado" : idAbonado,
                    "idCentroDeportivo" : idCentroDeportivo,
                    "nombre" : nombre,
                    "apellidos" : apellidos,
                    "direccion" : direccion,
                    "ciudad" : ciudad,
                    "provincia" : provincia,
                    "pais" : pais,
                    "codigoPostal" : codigoPostal,
                    "email" : email,
                    "numeroTelefono" : numeroTelefono,
                    "fechaNacimiento" : dateformatter.string(from: fechaNacimiento)] as [String : Any]
        return try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
    }
}
