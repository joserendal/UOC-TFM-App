//
//  PaymentsTest.swift
//  gGymUITests
//
//  Created by Jose Enrique Álvarez on 04/05/2019.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import XCTest
@testable import gGym

class PaymentsTest: XCTestCase {
    
    var client: Client?
    
    override func setUp() {
        super.setUp()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
    }
    
    func testCreateClientAndPayReceipt() {
        let random = Int.random(in: 0 ... 10000)
        // Launch application
        let app = XCUIApplication()
        // Login into the system
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
        // Move to the clients section
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Abonados"]/*[[".cells.buttons[\"Abonados\"]",".buttons[\"Abonados\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        // Hit create button
        let listadoDeAbonadosNavigationBar = app.navigationBars["Listado de Abonados"]
        listadoDeAbonadosNavigationBar.buttons["Crear"].tap()
        let scrollViewsQuery = app.scrollViews
        let nombreElementsQuery = scrollViewsQuery.otherElements.containing(.staticText, identifier:"Nombre (*)")
        // Name of the client
        let nameField = nombreElementsQuery.children(matching: .textField).element(boundBy: 0)
        nameField.tap()
        nameField.typeText("Testing")
        // Surname of the client
        let surnameField = nombreElementsQuery.children(matching: .textField).element(boundBy: 1)
        surnameField.tap()
        surnameField.typeText(String(random))
        nombreElementsQuery.children(matching: .textField).element(boundBy: 5).swipeUp()
        // Telephone number
        let telephoneField = nombreElementsQuery.children(matching: .textField).element(boundBy: 7)
        telephoneField.tap()
        telephoneField.typeText("66622233")
        // receipt
        let receiptField = nombreElementsQuery.children(matching: .textField).element(boundBy: 9)
        receiptField.tap()
        receiptField.typeText("25.5")
        // Tap save button
        scrollViewsQuery.otherElements.buttons["Guardar Abonado"].tap()
        // Go to the main menu
        listadoDeAbonadosNavigationBar.buttons["Menú"].tap()
        // Move to the payments section
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Pagos"]/*[[".cells.buttons[\"Pagos\"]",".buttons[\"Pagos\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        // Switch to pendings segment
        let pendientesDeCobroButton = tablesQuery.buttons["Pendientes de cobro"]
        pendientesDeCobroButton.tap()
        // Assert the list has contents
        XCTAssertFalse(app.tables["Empty list"].exists)
        // tap in the customer
        let staticText = tablesQuery.staticTexts[String(random) + ", Testing"]
        staticText.tap()
        // Hit pay button
        app.otherElements.containing(.navigationBar, identifier:"Detalles del Abono").children(matching: .other).element.buttons["Guardar"].tap()
        // Assert user exists in the paid section
        XCTAssertTrue(tablesQuery.staticTexts[String(random) + ", Testing"].exists)
        // Switch segment
        pendientesDeCobroButton.tap()
        // Assert the list is empty
        XCTAssertTrue(app.tables["Empty list"].exists)
    }
}
