//
//  Receipt.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 27/4/19.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import Foundation

class Receipt: NSObject {
    

    var idAbonado: CLong
    var importe: CDouble
    var periodicidad: String
    
    init?(idAbonado: CLong, importe: CDouble, periodicidad: String) {
        self.idAbonado = idAbonado
        self.importe = importe
        self.periodicidad = periodicidad
    }
    
    var jsonRepresentation : Data {
        let dict = ["idAbonado" : String(idAbonado),
                    "importe" : String(importe),
                    "periodicidad" : periodicidad] as [String : Any]
        return try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
    }
    
}
