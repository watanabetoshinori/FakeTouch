//
//  ControlsViewController.swift
//  iOS Example
//
//  Created by Watanabe Toshinori on 2/8/19.
//  Copyright © 2019 Watanabe Toshinori. All rights reserved.
//

import UIKit

class ControlsViewController: UITableViewController {
    
    @IBOutlet weak var stepperLabel: UILabel!
    
    // MARK: - Viewcontroller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Actions

    @IBAction func stepperDidChanged(_ sender: UIStepper) {
        stepperLabel.text = String(Int(sender.value))
    }

}
