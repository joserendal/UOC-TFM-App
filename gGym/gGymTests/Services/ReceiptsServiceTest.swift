//
//  ReceiptsServiceTest.swift
//  gGymTests
//
//  Created by Jose Enrique Álvarez on 03/05/2019.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//
import XCTest
@testable import gGym

class ReceiptsServiceTest: XCTestCase {
    
    // UNIT TESTING
    func testGetReceipt() {
        // Call service for getting the receipt
        let receipt = ReceiptsService.getReceiptForUser(idUser: 1, idClient: 1)
        // Asserts
        XCTAssertEqual(receipt.idAbonado, 1)
        XCTAssertTrue(receipt.importe > 0, "Importe no parseado")
        XCTAssertFalse(receipt.periodicidad.isEmpty, "Periodicidad no parseado")
    }
    
    func testGetInvalidReceipt() {
        // Call service for getting the receipt
        let receipt = ReceiptsService.getReceiptForUser(idUser: 1500000000, idClient: 1500000000)
        // Asserts
        XCTAssertEqual(receipt.importe, 0)
        XCTAssertTrue(receipt.periodicidad.isEmpty)
    }
    
    func testCreateInvalidReceipt() {
        // create a receipt for a non existing user
        let receipt = Receipt(idAbonado: 15000000, importe: 0, periodicidad: "")
        // Call backend service
        let result = ReceiptsService.createReceipt(idUser: 1, receipt: receipt!)
        // Asserts
        XCTAssertFalse(result)
    }
    
    // PERFORMANCE TESTING
    func testGetReceiptsPerformance(){
        self.measure {
            testGetReceipt()
        }
    }
}
