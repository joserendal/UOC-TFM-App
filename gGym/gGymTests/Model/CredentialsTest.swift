//
//  CredentialsTest.swift
//  gGymTests
//
//  Created by Jose Enrique Álvarez on 03/05/2019.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import XCTest
@testable import gGym

class CredentialsTest: XCTestCase {
    
    var credentials: Credentials?
    
    override func setUp() {
        super.setUp()
        // Create an object
        credentials = Credentials(idUsuario: 1, email: "a@a.com", password: "password")
    }
    
    func testObjectCreation() {
        // Assert object was created correctly
        XCTAssertEqual(credentials?.idUsuario, 1)
        XCTAssertEqual(credentials?.email, "a@a.com")
        XCTAssertEqual(credentials?.password, "password")
    }
    
    func testEncodeDecode() {
        // Save credentials object
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: credentials!)
        let userDefaults: UserDefaults = UserDefaults.standard
        userDefaults.set(encodedData, forKey: "credentials")
        userDefaults.synchronize()
        // Recover credentials object saved
        // Check if credentials stored. If so, display on screen
        if let data = userDefaults.object(forKey: "credentials") {
            let credentials = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as? Credentials
            XCTAssertEqual(credentials?.email, "a@a.com")
            XCTAssertEqual(credentials?.password, "password")
        }
    }
    
}
