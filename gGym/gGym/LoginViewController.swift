//
//  ViewController.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 13/4/19.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Clean password
        usernameField.text = nil
        passwordField.text = nil
        // Check if credentials stored. If so, display on screen
        let userDefaults: UserDefaults = UserDefaults.standard
        if let data = userDefaults.object(forKey: "credentials") {
            let credentials = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as? Credentials
            usernameField.text = credentials?.email
            passwordField.text = credentials?.password
        }
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
        // Show loading dialog
        activityIndicator.startAnimating()
        // Create a credentials object
        let credentialsObject = Credentials(idUsuario: 0, email: username, password: password)
        // Call the API and get the response
        let credentials = CredentialsService.login(credentials: credentialsObject)
        // If request was wrong
        if(credentials.idUsuario == 0) {
            // Hide loading dialog
            activityIndicator.stopAnimating()
            // Display an error message
            DialogHelper.displayErrorDialogWithoutAction(title: "Error", message: "No se ha podido autenticar en el sistema", button: "Cerrar", callerController: self)
            // End the execution of the action
            return
        }
        // Save the credentials object in the database
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: credentialsObject!)
        let userDefaults: UserDefaults = UserDefaults.standard
        userDefaults.set(encodedData, forKey: "credentials")
        userDefaults.synchronize()
        // Hide loading dialog
        activityIndicator.stopAnimating()
        // Send the user to the Main Menu
        self.performSegue(withIdentifier: "mainMenuSegue", sender: self)
    }

}

