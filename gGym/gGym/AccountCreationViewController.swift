//
//  AccountCreationControllerViewController.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 13/4/19.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import UIKit

class AccountCreationViewController: UITabBarController {

    // Configurar barra de navegación
    override func viewWillAppear(_ animated: Bool) {
        // View title
        navigationItem.title = "Crear una cuenta"
        // Create button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Crear", style: .plain, target: self, action: #selector(AccountCreationViewController.createButtonTapped))

    }
    
    func createButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
