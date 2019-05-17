//
//  LoginControllerTest.swift
//  gGymUITests
//
//  Created by Jose Enrique Álvarez on 04/05/2019.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import XCTest
@testable import gGym

class LoginTest: XCTestCase {
    
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
        // Tap outside text field for hiding keyboard
        XCUIApplication().otherElements.containing(.navigationBar, identifier:"gGym.LoginView").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        // Get the password field and clean it
        let passwordField = app.secureTextFields["Password"]
        passwordField.tap()
        passwordField.buttons["Clear text"].tap()
        passwordField.typeText("thisisthepassword")
        // Tap outside text field for hiding keyboard
        XCUIApplication().otherElements.containing(.navigationBar, identifier:"gGym.LoginView").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        // Hit Login Button
        app.buttons["Iniciar Sesión"].tap()
        // Assert dialog is displayed
        XCTAssertEqual(app.alerts.element.label, "Error")
    }
    
    // Login with valid credentials redirects the user to the main menu
    func testLoginAndLogout() {
        // Launch application
        let app = XCUIApplication()
        // Get email text field and type the username
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
        // Assert the user has arrived to the main menu
        XCTAssertTrue(app.tables/*@START_MENU_TOKEN@*/.cells.staticTexts["Bienvenido/a "]/*[[".cells.staticTexts[\"Bienvenido\/a \"]",".staticTexts[\"Bienvenido\/a \"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.exists)
        // Check the legal info is displayed
        let tablesQuery = app.tables
        XCTAssertTrue(tablesQuery/*@START_MENU_TOKEN@*/.cells.staticTexts["Esta aplicación es el Trabajo Final de Master de Jose Enrique Álvarez Rendal. Copyright 2019."]/*[[".cells.staticTexts[\"Esta aplicación es el Trabajo Final de Master de Jose Enrique Álvarez Rendal. Copyright 2019.\"]",".staticTexts[\"Esta aplicación es el Trabajo Final de Master de Jose Enrique Álvarez Rendal. Copyright 2019.\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.exists)
        // Tap on close session button
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Cerrar Sesión"]/*[[".cells.buttons[\"Cerrar Sesión\"]",".buttons[\"Cerrar Sesión\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        // Assert the user has arrived to the login button
        XCTAssertTrue(app.staticTexts["Iniciar sesión en gGym"].exists)
    }
}
