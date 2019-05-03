//
//  PaymentsServiceTest.swift
//  gGymTests
//
//  Created by Jose Enrique Álvarez on 03/05/2019.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//
import XCTest
@testable import gGym

class PaymentsServiceTest: XCTestCase {
    
    // UNIT TESTING
    func testGetPendingPayments() {
        // Call backend service for getting pending payments
        let pending = PaymentsService.getPendingPayments(idCenter: 1, idUser: 1, month: 1, year: 2011)
        // Assert there are pending payments
        XCTAssertTrue(pending.count > 0, "No se han recuperado pagos pendientes")
        XCTAssertEqual(pending[0].anio, 2011)
        XCTAssertEqual(pending[0].mes, 1)
        XCTAssertTrue(pending[0].idAbonado.idAbonado > 0, "No se ha recuperado el abonado")
    }
    
    func testGetPaidPayments() {
        // Call backend service for getting pending payments
        let pending = PaymentsService.getPaidPayments(idCenter: 1, idUser: 1, month: 3, year: 2019)
        // Assert there are pending payments
        XCTAssertTrue(pending.count > 0, "No se han recuperado pagos pagados")
        XCTAssertEqual(pending[0].anio, 2019)
        XCTAssertEqual(pending[0].mes, 3)
        XCTAssertTrue(pending[0].idAbonado.idAbonado > 0, "No se ha recuperado el abonado")
    }
    
    func testCreateInvalidPayment() {
        // Recover a client
        let client = ClientsService.getClientInformation(idClient: 1, idUser: 1)
        // Create an invalid payment
        let payment = Payment(idPagoAbonado: 0, idAbonado: client, mes: 150, anio: 1500000)
        // Call backend service for creating operation
        let result = PaymentsService.createPayment(idUser: 1, payment: payment!)
        // Assert
        XCTAssertFalse(result, "Se ha registrado un pago inválido")
    }
    
    // PERFORMANCE TESTING
    func testGetPendingPaymentsPerformance(){
        self.measure {
            testGetPendingPayments()
        }
    }
    
    func testGetPaidPaymentsPerformance() {
        self.measure {
            testGetPaidPayments()
        }
    }
}
