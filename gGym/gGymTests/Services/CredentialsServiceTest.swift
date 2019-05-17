//
//  CredentialsServiceTest.swift
//  gGymTests
//
//  Created by Jose Enrique Álvarez on 03/05/2019.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import XCTest
@testable import gGym

class CredentialsServiceTest: XCTestCase {

    // UNIT TESTING
    func testLogin() {
        // Create an invalid credentials pair
        var credentials = Credentials(idUsuario: 0, email: "jalvarezrend@uoc.edu", password: "password")
        // Call login service
        credentials = CredentialsService.login(credentials: credentials!)
        // Assert invalid login
        XCTAssertNotEqual(credentials!.idUsuario, 0)
    }
    
    func testLoginInvalidCredentials() {
        // Create an invalid credentials pair
        var credentials = Credentials(idUsuario: 0, email: "a@a.com", password: "password")
        // Call login service
        credentials = CredentialsService.login(credentials: credentials!)
        // Assert invalid login
        XCTAssertEqual(credentials!.idUsuario, 0)
    }
    
    func testCreateInvalidCredentials() {
        // Create an invalid credentials pair
        var credentials = Credentials(idUsuario: 0, email: "aaaa", password: "abc")
        // Call login service
        credentials = CredentialsService.createCredentials(credentials: credentials!)
        // Assert invalid login
        XCTAssertEqual(credentials!.idUsuario, 0)
    }
    
    // PERFORMANCE TESTING
    func testLoginPerformance() {
        // This is an example of a performance test case.
        self.measure {
            testLogin()
        }
    }
}
