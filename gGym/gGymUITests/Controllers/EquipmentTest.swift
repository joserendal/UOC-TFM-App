//
//  EquipmentTest.swift
//  gGymUITests
//
//  Created by Jose Enrique Álvarez on 04/05/2019.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import XCTest
@testable import gGym

class EquipmentTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
    }
    
    // Create a new equipment in the system
    func testCreateEquipment() {
        // Launch Application
        let app = XCUIApplication()
        // Login into the system
        // Get email text field and clean it
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
        // Tap outside text field for hiding keyboard
        XCUIApplication().otherElements.containing(.navigationBar, identifier:"gGym.LoginView").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        // Hit Login Button
        app.buttons["Iniciar Sesión"].tap()
        // Move to the Equipments menu
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Equipamiento"]/*[[".cells.buttons[\"Equipamiento\"]",".buttons[\"Equipamiento\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        // Tap create button
        app.navigationBars["Lista de Equipamiento"].buttons["Crear"].tap()
        // Set the name of the equipment
        var random = Int.random(in: 0 ... 10000)
        let introduzcaElNombreDelEquipamientoTextField = app.textFields["Introduzca el nombre del equipamiento"]
        introduzcaElNombreDelEquipamientoTextField.tap()
        introduzcaElNombreDelEquipamientoTextField.typeText("AA Equipamiento " + String(random))
        // Set the description of the equipment
        let introduzcaLaDescripciNDelEquipamientoTextField = app.textFields["Introduzca la descripción del equipamiento"]
        introduzcaLaDescripciNDelEquipamientoTextField.tap()
        introduzcaLaDescripciNDelEquipamientoTextField.typeText("AA Descripción del equipamiento " + String(random))
        // Hit save button
        app.navigationBars["Equipamiento"].buttons["Guardar"].tap()
        // Click in the cell containing the equipment created
        tablesQuery.cells.containing(.staticText, identifier:"AA Equipamiento " + String(random)).children(matching: .staticText).matching(identifier: "AA Equipamiento " + String(random)).element(boundBy: 0).swipeRight()
        // Asserts
        introduzcaElNombreDelEquipamientoTextField.tap()
        XCTAssertEqual(introduzcaElNombreDelEquipamientoTextField.value as! String, "AA Equipamiento " + String(random))
        XCTAssertEqual(introduzcaLaDescripciNDelEquipamientoTextField.value as! String, "AA Descripción del equipamiento " + String(random))
    }
    
    // Generate a reservation in the system for the equipment
    func testGenerateReservationForEquipment() {
        // Launch application
        let app = XCUIApplication()
        // Login into the applicaiton
        // Get email text field and clean it
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
        // Tap outside text field for hiding keyboard
        XCUIApplication().otherElements.containing(.navigationBar, identifier:"gGym.LoginView").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        // Hit Login Button
        app.buttons["Iniciar Sesión"].tap()
        // Go to the equipment menu
        app.tables/*@START_MENU_TOKEN@*/.buttons["Equipamiento"]/*[[".cells.buttons[\"Equipamiento\"]",".buttons[\"Equipamiento\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let tablesQuery = app.tables
        // Do access to the testing equipment
        tablesQuery.cells.containing(.staticText, identifier:"AAA Testing Equipment").children(matching: .staticText).matching(identifier: "AAA Testing Equipment").element(boundBy: 1).tap()
        // Hit reservate button
        app.navigationBars["Equipamiento"].buttons["Reservar"].tap()
        // Set hours
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        // Tap save button
        elementsQuery.buttons["Guardar Reserva"].tap()
        // Assert text view contains reservation
        let textView = app.otherElements.containing(.navigationBar, identifier:"Equipamiento").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element
        // Get the text of the field and assert its not equal to default text
        let reserationsText: String = textView.value as! String
        XCTAssertFalse(reserationsText.isEmpty)
        XCTAssertNotEqual(reserationsText, "No existen reservas por el momento")
    }
}

