//
//  ClientsTest.swift
//  gGymUITests
//
//  Created by Jose Enrique Álvarez on 04/05/2019.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import XCTest
@testable import gGym

class ClientsTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
    }
    
    // Test the update of a client in the system
    func testUpdateClient() {
        let random = Int.random(in: 0 ... 10000)
        // Launch application
        let app = XCUIApplication()
        // Login into the application
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.buttons["Clear text"].tap()
        emailTextField.typeText("jalvarezrend@uoc.edu")
        // Tap outside text field for hiding keyboard
        XCUIApplication().otherElements.containing(.navigationBar, identifier:"gGym.LoginView").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        // Get the password field and clean it
        let passwordField = app.secureTextFields["Password"]
        passwordField.tap()
        passwordField.buttons["Clear text"].tap()
        passwordField.typeText("password")
        app.buttons["Iniciar Sesión"].tap()
        // Go into the Abonados Menu
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Abonados"]/*[[".cells.buttons[\"Abonados\"]",".buttons[\"Abonados\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        // Click in the user
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Álvarez, Jose Enrique"]/*[[".cells.staticTexts[\"Álvarez, Jose Enrique\"]",".staticTexts[\"Álvarez, Jose Enrique\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        // Modify zip code field
        let scrollViewsQuery = app.scrollViews
        let nombreElementsQuery = scrollViewsQuery.otherElements.containing(.staticText, identifier:"Nombre (*)")
        // Get zip code field and update it
        let zipCodeField = nombreElementsQuery.children(matching: .textField).element(boundBy: 6)
        zipCodeField.tap()
        zipCodeField.buttons["Clear text"].tap()
        zipCodeField.typeText(String(random))
        // Get the phone number and update it
        let telephoneNumberField = nombreElementsQuery.children(matching: .textField).element(boundBy: 7)
        telephoneNumberField.tap()
        telephoneNumberField.buttons["Clear text"].tap()
        telephoneNumberField.typeText(String(random))
        // Hit save button
        scrollViewsQuery.otherElements.buttons["Guardar Abonado"].tap()
        // Enter again the list
        tablesQuery.staticTexts["Álvarez, Jose Enrique"].tap()
        // Assert text has changed
        XCTAssertEqual(zipCodeField.value as! String, String(random))
        XCTAssertEqual(telephoneNumberField.value as! String, String(random))
    }
}

