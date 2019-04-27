//
//  DateSelectionPopupController.swift
//  gGym
//
//  Created by Jose Enrique Álvarez on 27/4/19.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//

import UIKit

class DateSelectionPopupController: UIViewController {
    
    // Outlets
    @IBOutlet weak var monthStepper: UIStepper!
    @IBOutlet weak var yearStepper: UIStepper!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    // variables
    var receivedMonth: Int?
    var receivedYear: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        monthStepper.value = Double((receivedMonth)!)
        monthLabel.text = String(describing: receivedMonth!)
        yearStepper.value = Double((receivedYear)!)
        yearLabel.text = String(describing: receivedYear!)
    }
    
    // Stepper changed
    @IBAction func monthStepperChanged(_ sender: Any) {
        monthLabel.text = String(describing: Int(monthStepper.value))
    }
    @IBAction func yearStepperChanged(_ sender: Any) {
        yearLabel.text = String(describing: Int(yearStepper.value))
    }
    
    // Action
    @IBAction func submitButtonTapped(_ sender: Any) {
        
    }
    
}
