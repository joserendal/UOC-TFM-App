//
//  FormValidator.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 18/4/19.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import Foundation
import UIKit

class FormValidator {
    
    // Validate whether a field is fulfilled with data. If not, display alert to the user.
    class func validateRequiredTextFieldAndDisplayAlert(textField: UITextField, fieldName: String, callerController: UIViewController) -> Bool {
        // Check if the field is present
        if (textField.text?.isEmpty)! {
            // Display validation error
            DialogHelper.displayErrorDialogWithoutAction(title: "Error", message: "El campo " + fieldName + " es requerido", button: "Cerrar", callerController: callerController)
            // Validation not succeded
            return false
        }
        // Validation OK
        return true
    }
    
    // Validate email address
    class func validateEmailAddressAndDisplayAlert(textField: UITextField, callerController: UIViewController) -> Bool {
        // Email regular expression
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        // Predicate for validation
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        // Validate email address with predicate
        if(!emailTest.evaluate(with: textField.text)) {
            // Display validation error
            DialogHelper.displayErrorDialogWithoutAction(title: "Error", message: "El email introducido no es válido", button: "Cerrar", callerController: callerController)
            // Validation not succeded
            return false
        }
        // Validation OK
        return true;
    }
    
}
