//
//  AppDelegate.swift
//  iOS Example
//
//  Created by Watanabe Toshinori on 2/6/19.
//  Copyright © 2019 Watanabe Toshinori. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var overlayWindow: OverlayWindow?

    // MARK: - Application lifecycle

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.overlayWindow = OverlayWindow(frame: UIScreen.main.bounds)
        overlayWindow?.makeKeyAndVisible()
        
        return true
    }

}
