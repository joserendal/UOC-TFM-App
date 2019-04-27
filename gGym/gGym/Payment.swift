//
//  Payment.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 22/4/19.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import Foundation

class Payment: NSObject {
    
    var idPagoAbonado: CLong
    var idAbonado: Client
    var mes: Int
    var anio: Int
    
    init?(idPagoAbonado: CLong, idAbonado: Client, mes: Int, anio: Int) {
        self.idPagoAbonado = idPagoAbonado
        self.idAbonado = idAbonado
        self.mes = mes
        self.anio = anio
    }
    
    var jsonRepresentation : Data {
        let dict = ["idAbonado" : ["idAbonado" : idAbonado.idAbonado] as [String : Any],
                    "mes" : String(mes),
                    "anio" : String(anio)] as [String : Any]
        return try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
    }
}
