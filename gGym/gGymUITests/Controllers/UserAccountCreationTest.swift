//
//  UserAccountCreationControllerTest.swift
//  gGymUITests
//
//  Created by Jose Enrique Álvarez on 04/05/2019.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import XCTest
@testable import gGym

class UserAccountCreationTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
    }
    
    // Test the navigation to the screen and segment changes
    func testSegmentChanges() {
        // Launch application
        let app = XCUIApplication()
        // Hit create account button
        app.buttons["Crear una cuenta"].tap()
        // Assert first segment fields are displayed
        XCTAssertTrue(app.staticTexts["Nombre (*)"].exists)
        XCTAssertTrue(app.staticTexts["Apellidos (*)"].exists)
        // Switch to second segment
        app/*@START_MENU_TOKEN@*/.buttons["Datos del centro"]/*[[".segmentedControls.buttons[\"Datos del centro\"]",".buttons[\"Datos del centro\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        // Assert first segment fields are not displayed
        XCTAssertFalse(app.staticTexts["Nombre (*)"].exists)
        XCTAssertFalse(app.staticTexts["Apellidos (*)"].exists)
        // Assert second segment fields are displayed
        let elementsQuery = app.scrollViews.otherElements
        XCTAssertTrue(elementsQuery.staticTexts["Nombre del centro (*)"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["Tipo de centro (*)"].exists)
        // Switch to third segment
        app/*@START_MENU_TOKEN@*/.buttons["Su cuenta"]/*[[".segmentedControls.buttons[\"Su cuenta\"]",".buttons[\"Su cuenta\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        // Assert fields
        XCTAssertTrue(app.staticTexts["Introduzca sus datos para iniciar sesión"].exists)
        XCTAssertTrue(app.staticTexts["Contraseña"].exists)
        // Hit cancel button
        app.buttons["Cancelar"].tap()
        // Assert we are returning to the login menu
        XCTAssertTrue(app.otherElements.containing(.navigationBar, identifier:"gGym.LoginView").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.exists)
    }
    
    func testValidationOfRequiredFields() {
        // Launch application
        let app = XCUIApplication()
        // Go to account creation section
        app.buttons["Crear una cuenta"].tap()
        // Try to create an account with an empty form
        let crearButton = app.navigationBars["Crear una cuenta"].buttons["Crear"]
        crearButton.tap()
        // Assert Error Dialog is Displayed
        XCTAssertTrue(app.alerts["Error"].staticTexts["Error"].exists)
        // Dismiss error dialog
        let cerrarButton = app.alerts["Error"].buttons["Cerrar"]
        cerrarButton.tap()
        // Hit in the name elemenet
        let element = app.otherElements.containing(.navigationBar, identifier:"Crear una cuenta").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .textField).element(boundBy: 0).tap()
        let textField = element.children(matching: .textField).element(boundBy: 1)
        textField.tap()
        textField.typeText("Juan Jose Diaz")
        // Switch segment
        app/*@START_MENU_TOKEN@*/.buttons["Datos del centro"]/*[[".segmentedControls.buttons[\"Datos del centro\"]",".buttons[\"Datos del centro\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let textField2 = app.scrollViews.otherElements.containing(.staticText, identifier:"Nombre del centro (*)").children(matching: .textField).element(boundBy: 0)
        textField2.tap()
        textField2.typeText("Juan Jose Diaz")
        // Hit create button
        crearButton.tap()
        // Assert Error Dialog is Displayed
        XCTAssertTrue(app.alerts["Error"].staticTexts["Error"].exists)
    }
    
    func testValidationPasswordsAreEqual() {
        // Launch application
        let app = XCUIApplication()
        // Hit create account button
        app.buttons["Crear una cuenta"].tap()
        // Name of the user
        var element = app.otherElements.containing(.navigationBar, identifier:"Crear una cuenta").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let textField = element.children(matching: .textField).element(boundBy: 0)
        textField.tap()
        textField.typeText("Jose Enrique")
        // Surname of the user
        let surnameTextField = element.children(matching: .textField).element(boundBy: 1)
        surnameTextField.tap()
        surnameTextField.typeText("Álvarez")
        // Birth date of the user
        let fechaDeNacimientoStaticText = app.staticTexts["Fecha de nacimiento (*)"]
        fechaDeNacimientoStaticText.swipeUp()
        // Country
        let countryField = element.children(matching: .textField).element(boundBy: 5)
        countryField.tap()
        countryField.typeText("España")
        // Switch segment
        let datosDelCentroButton = app/*@START_MENU_TOKEN@*/.buttons["Datos del centro"]/*[[".segmentedControls.buttons[\"Datos del centro\"]",".buttons[\"Datos del centro\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        datosDelCentroButton.tap()
        let scrollViewsQuery = app.scrollViews
        let nombreDelCentroElementsQuery = scrollViewsQuery.otherElements.containing(.staticText, identifier:"Nombre del centro (*)")
        // Nombre del centro
        let centerNameField = nombreDelCentroElementsQuery.children(matching: .textField).element(boundBy: 0)
        centerNameField.tap()
        centerNameField.typeText("Centro Deportivo")
        // Dismiss keyboard
        let dismissKeyboard = app.otherElements.containing(.navigationBar, identifier:"Crear una cuenta").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        dismissKeyboard.tap()
        // Direccion del centro
        let addressField = nombreDelCentroElementsQuery.children(matching: .textField).element(boundBy: 1)
        addressField.tap()
        addressField.typeText("Avenida de las Mercedes")
        // Dismiss keyboard
        dismissKeyboard.tap()
        // Ciudad del centro
        let cityField = nombreDelCentroElementsQuery.children(matching: .textField).element(boundBy: 2)
        cityField.tap()
        cityField.typeText("Oviedo")
        // Dismiss keyboard
        dismissKeyboard.tap()
        // Provincia
        let provinceField = nombreDelCentroElementsQuery.children(matching: .textField).element(boundBy: 3)
        provinceField.tap()
        provinceField.typeText("Asturias")
        // Dismiss keyboard
        dismissKeyboard.tap()
        // Pais
        let centerCountryField = nombreDelCentroElementsQuery.children(matching: .textField).element(boundBy: 4)
        centerCountryField.tap()
        centerCountryField.typeText("España")
        // Dismiss keyboard
        dismissKeyboard.tap()
        // Codigo postal
        let zipCodeField = nombreDelCentroElementsQuery.children(matching: .textField).element(boundBy: 5)
        zipCodeField.tap()
        zipCodeField.typeText("33010")
        // Dismiss keyboard
        dismissKeyboard.tap()
        // Número de teléfono
        let telephoneField = nombreDelCentroElementsQuery.children(matching: .textField).element(boundBy: 6)
        telephoneField.tap()
        telephoneField.typeText("695536365")
        // Dismiss keyboard
        dismissKeyboard.tap()
        // Email de Contacto
        let emailField = nombreDelCentroElementsQuery.children(matching: .textField).element(boundBy: 7)
        emailField.tap()
        emailField.typeText("abc@abc.com")
        // Switch segment
        app/*@START_MENU_TOKEN@*/.buttons["Su cuenta"]/*[[".segmentedControls.buttons[\"Su cuenta\"]",".buttons[\"Su cuenta\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        // Fill account details
        element = app.otherElements.containing(.navigationBar, identifier:"Crear una cuenta").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let accountField = element.children(matching: .textField).element
        accountField.tap()
        accountField.typeText("jalvarezrendal@uoc.edu")
        // Switch to password 1 field
        let password1Field = element.children(matching: .secureTextField).element(boundBy: 0)
        password1Field.tap()
        password1Field.typeText("password")
        // Switch to password 2 field
        let password2Field = element.children(matching: .secureTextField).element(boundBy: 1)
        password2Field.tap()
        password2Field.typeText("pass")
        // Hit create account button
        app.navigationBars["Crear una cuenta"].buttons["Crear"].tap()
        // Assert Error Dialog is Displayed
        XCTAssertTrue(app.alerts["Error"].exists)
    }
    
}
