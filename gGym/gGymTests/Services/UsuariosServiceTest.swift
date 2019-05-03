//
//  UsuariosServiceTest.swift
//  gGymTests
//
//  Created by Jose Enrique Álvarez on 03/05/2019.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import XCTest
@testable import gGym

class UsuariosServiceTest: XCTestCase {
    
    func testCreateInvalidUser() {
        // Create an invalid user
        var user = User(nombre: "", apellidos: "", fechaNacimiento: Date.init(), pais: "ES")
        // Call backend service
        user = UsuariosService.createUser(user: user)
        // Assert invalid login
        XCTAssertEqual(user!.idUsuario, 0)
    }
    
}
