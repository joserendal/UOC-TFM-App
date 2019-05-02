//
//  Equipment.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 02/05/2019.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import Foundation

class Equipment: NSObject {
    
    var idEquipamiento: CLong
    var idCentroDeportivo: CLong
    var nombreEquipamiento: String
    var descripcionEquipamiento: String
    
    init?(idEquipamiento: CLong, idCentroDeportivo: CLong, nombreEquipamiento: String, descripcionEquipamiento: String) {
        self.idEquipamiento = idEquipamiento
        self.idCentroDeportivo = idCentroDeportivo
        self.nombreEquipamiento = nombreEquipamiento
        self.descripcionEquipamiento = descripcionEquipamiento
    }
}
