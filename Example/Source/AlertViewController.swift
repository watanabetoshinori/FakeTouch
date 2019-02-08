//
//  AlertViewController.swift
//  iOS Example
//
//  Created by Watanabe Toshinori on 2/8/19.
//  Copyright © 2019 Watanabe Toshinori. All rights reserved.
//

import UIKit

class AlertViewController: UITableViewController {
    
    // MARK: - Viewcontroller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Actions
    
    @IBAction func alertTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Alert", message: "Alert!", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("OK")
        }))
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func confirmTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Confirm", message: "Are you sure?", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("OK")
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void in
            print("Cancel")
        }))
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func promptTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Prompt", message: "Please input text.", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            let input = alertController.textFields?.first?.text ?? "None"
            print(input)
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void in
            print("Cancel")
        }))
        
        alertController.addTextField { (textField) -> Void in
            textField.placeholder = "Enter text"
        }
        
        present(alertController, animated: true, completion: nil)
    }

}
