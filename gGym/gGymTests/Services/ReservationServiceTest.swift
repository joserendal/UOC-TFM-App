//
//  ReservationServiceTest.swift
//  gGymTests
//
//  Created by Jose Enrique Álvarez on 03/05/2019.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//
import XCTest
@testable import gGym

class ReservationServiceTest: XCTestCase {
    
    // UNIT TESTING
    func testCreateInvalidReservation() {
        // Create reservation
        let reservation = Reservation(idEquipamiento: 0, idReserva: 0, idAbonado: 0, reservaDesde: Date.init(), reservaHasta: Date.init())
        // Call service for creating reservation
        let result = ReservationService.createReservationForEquipment(idUser: 1, reservation: reservation!)
        // Asserts
        XCTAssertFalse(result)
    }
}
