//
//  LoginControllerTest.swift
//  gGymUITests
//
//  Created by Jose Enrique Álvarez on 04/05/2019.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import XCTest
@testable import gGym

class LoginControllerTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
    }
    
    // Try to login with invalid credentials produces alert message
    func testLoginWithInvalidCredentialsDisplaysErrorMessage() {
        // Launch application
        let app = XCUIApplication()
        // Get email text field and clean it
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.buttons["Clear text"].tap()
        emailTextField.typeText("newemail@domain.com")
        app.keyboards.buttons["Hide keyboard"]
        // Get the password field and clean it
        let passwordField = app.secureTextFields["Password"]
        passwordField.tap()
        passwordField.buttons["Clear text"].tap()
        passwordField.typeText("thisisthepassword")
        app.keyboards.buttons["Hide keyboard"]
        // Hit Login Button
        app.buttons["Iniciar Sesión"].tap()
        // Assert dialog is displayed
        XCTAssertEqual(app.alerts.element.label, "Error")
        XCTAssertTrue(app.alerts.element.staticTexts["Por favor, revise sus credenciales"].exists)
    }
}
