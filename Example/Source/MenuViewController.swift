//
//  MenuViewController.swift
//  iOS Example
//
//  Created by Watanabe Toshinori on 2/8/19.
//  Copyright © 2019 Watanabe Toshinori. All rights reserved.
//

import UIKit
import StoreKit
import SafariServices
import LocalAuthentication

class MenuViewController: UITableViewController, SKStoreProductViewControllerDelegate {
    
    // MARK: - Viewcontroller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Actions
    
    @IBAction func showStoreProductTapped(_ sender: Any) {
        let parameters = [SKStoreProductParameterITunesItemIdentifier: 364709193]

        let viewController = SKStoreProductViewController()
        viewController.delegate = self
        viewController.loadProduct(withParameters: parameters) { (result, error) in
            if let error = error {
                print(error)
            }
        }
        present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func showSafariTapped(_ sender: Any) {
        let url = URL(string: "https://google.com")!
        let viewControlller = SFSafariViewController(url: url)
        present(viewControlller, animated: true, completion: nil)
    }
    
    @IBAction func showPermissionTapped(_ sender: Any) {
        let context = LAContext()
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Test") { (success, error) in
            
        }
    }
    
    // MARK: - SKStoreProductViewController Delegate

    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        navigationController?.dismiss(animated: true, completion: nil)
    }

}
