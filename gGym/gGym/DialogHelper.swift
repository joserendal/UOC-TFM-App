//
//  DialogHelper.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 18/4/19.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import Foundation
import UIKit

class DialogHelper: UIVisualEffectView {
    
    // Displays an error dialog as an informative message. No action is taken when user hits button.
    class func displayErrorDialogWithoutAction(title: String, message: String, button: String, callerController: UIViewController) {
        // Display an error message
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: button, style: .default))
        callerController.present(alertController, animated: true, completion: nil)
    }

}
