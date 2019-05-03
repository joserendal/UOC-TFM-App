//
//  EquipmentsServiceTest.swift
//  gGymTests
//
//  Created by Jose Enrique Álvarez on 03/05/2019.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//
import XCTest
@testable import gGym

class EquipmentsServiceTest: XCTestCase {
    
    // UNIT TESTING
    func testEquipmentsForCenter() {
        // Call service for recovering equipments
        let equipments = EquipmentsService.getEquipmentsForCenter(centerId: 1, userId: 1)
        // Asserts
        XCTAssertTrue(equipments.count > 0)
        XCTAssertEqual(equipments[0].idCentroDeportivo, 1)
        XCTAssertFalse(equipments[0].nombreEquipamiento.isEmpty)
        XCTAssertFalse(equipments[0].descripcionEquipamiento.isEmpty)
    }
    
    func testEquipmentsForInvalidCenter() {
        // Call service for recovering equipments
        let equipments = EquipmentsService.getEquipmentsForCenter(centerId: 1500000000, userId: 1)
        // Asserts
        XCTAssertEqual(equipments.count, 0)
    }
    
    func testCreateInvalidEquipmentForCenter() {
        // create an equipment for calling backend
        let equipments = Equipment(idEquipamiento: 0, idCentroDeportivo: 0, nombreEquipamiento: "", descripcionEquipamiento: "")
        // Call service for creating equipment
        let result = EquipmentsService.createEquipment(idUser: 1, equipment: equipments!)
        // Asserts
        XCTAssertFalse(result)
    }
    
    // PERFORMANCE TESTING
    func testGetEquipmentsForCenterPerformance(){
        self.measure {
            testEquipmentsForCenter()
        }
    }
}
