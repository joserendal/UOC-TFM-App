//
//  Reservation.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 02/05/2019.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import Foundation

class Reservation: NSObject {
    
    var idEquipamiento: CLong
    var idReserva: CLong
    var idAbonado: CLong
    var reservaDesde: Date
    var reservaHasta: Date
    
    init?(idEquipamiento: CLong, idReserva: CLong, idAbonado: CLong, reservaDesde: Date, reservaHasta: Date) {
        self.idEquipamiento = idEquipamiento
        self.idReserva = idReserva
        self.idAbonado = idAbonado
        self.reservaDesde = reservaDesde
        self.reservaHasta = reservaHasta
    }
    
    var jsonRepresentation : Data {
        // Date formatter
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        // Date dictionary
        let dict = ["idEquipamiento" : String(idEquipamiento),
                    "idAbonado" : String(idAbonado),
                    "reservaDesde" : dateformatter.string(from: reservaDesde),
                    "reservaHasta" : dateformatter.string(from: reservaHasta)] as [String : Any]
        return try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
    }
    
}
