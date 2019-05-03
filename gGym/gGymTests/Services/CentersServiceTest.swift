//
//  CentersServiceTest.swift
//  gGymTests
//
//  Created by Jose Enrique Álvarez on 03/05/2019.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import XCTest
@testable import gGym

class CentersServiceTest: XCTestCase {
    
    // UNIT TESTING
    func testCreateInvalidCenter() {
        // Create a center
        var center = Center(idGestor: 100, nombreCentro: "", tipoCentro: "", direccion: "", ciudad: "", provincia: "", pais: "", codigoPostal: "", privado: false, numeroTelefono: "", emailContacto: "")
        // Call creation service
        center = CenterService.createCenters(center: center!, idUsuario: 1)
        // Assert center not created
        XCTAssertEqual(center!.idCentro, 0)
    }
    
    func testGetInvalidCenter() {
        // Get the center associated to an invalid user
        let center = CenterService.getCenter(idUsuario: 15000000)
        // Assert center empty
        XCTAssertEqual(center.idCentro, 0)
        XCTAssertTrue(center.nombreCentro.isEmpty, "Center name not empty")
    }
    
    func testGetValidCenter() {
        // Get the center associated to an invalid user
        let center = CenterService.getCenter(idUsuario: 1)
        // Assert center empty
        XCTAssertEqual(center.idCentro, 1)
        XCTAssertEqual(center.nombreCentro, "Max deportes")
        XCTAssertEqual(center.tipoCentro, "Gimnasio")
        XCTAssertEqual(center.direccion, "c/Urbanizacion privada, 15 bajo")
    }
    
    // PERFORMANCE TESTING
    func testGetCenterPerformance() {
        // This is an example of a performance test case.
        self.measure {
            testGetValidCenter()
        }
    }
}
