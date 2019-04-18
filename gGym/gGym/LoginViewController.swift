//
//  ViewController.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 13/4/19.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameField.text = nil
        passwordField.text = nil
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        // Get the username and password introduced by the user
        let username:String = usernameField.text!
        let password:String = passwordField.text!
        // Check both fields are fulfilled
        if(username.isEmpty || password.isEmpty) {
            // Display an error message
            let alertController = UIAlertController(title: "Error", message: "Por favor, revise sus credenciales", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Cerrar", style: .default))
            self.present(alertController, animated: true, completion: nil)
            // End the execution of the action
            return
        }
        // Create a credentials object
        let credentialsObject = Credentials(email: username, password: password)
        // Call the API and get the response
        let success = CredentialsService.login(credentials: credentialsObject)
        // If request was wrong
        if(!success) {
            // Display an error message
            DialogHelper.displayErrorDialogWithoutAction(title: "Error", message: "No se ha podido autenticar en el sistema", button: "Cerrar", callerController: self)
            
            /*let alertController = UIAlertController(title: "Error", message: "No se ha podido autenticar en el sistema", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Cerrar", style: .default))
            self.present(alertController, animated: true, completion: nil)*/
            // End the execution of the action
            return
        }
    }

}

