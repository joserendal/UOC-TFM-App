//
//  MainMenu.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 13/4/19.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import UIKit

class MainMenuViewController: UITableViewController {
    
    // Outlets
    @IBOutlet weak var usernameLabel: UILabel!

    // View initial setup
    override func viewDidLoad() {
        super.viewDidLoad()
        // Recover the user information stored and print the email address in the screen
        let userDefaults: UserDefaults = UserDefaults.standard
        if let data = userDefaults.object(forKey: "credentials") {
            let credentials = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as? Credentials
            usernameLabel.text = credentials?.email
        }
        // Recover the information about the user and save it locally
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Remove backward button
        navigationItem.setHidesBackButton(true, animated: true)
    }

}
