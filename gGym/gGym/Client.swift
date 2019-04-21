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
    
    init?(nombre: String, apellidos: String, direccion: String, ciudad: String, provincia: String, pais: String, codigoPostal: String, email: String, numeroTelefono: String) {
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
    }
    
    
}
