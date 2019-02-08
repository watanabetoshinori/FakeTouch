//
//  OverlayWindow.swift
//  iOS Example
//
//  Created by Watanabe Toshinori on 2/6/19.
//  Copyright © 2019 Watanabe Toshinori. All rights reserved.
//

import UIKit
import FakeTouch

class OverlayWindow: UIWindow {

    // MARK: - Initializing a UIWindow
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initialize()
    }
    
    convenience init() {
        self.init(frame: .zero)
        
        initialize()
    }
    
    private func initialize() {
        TouchRecorder.shared.excludeWindow.append(self)
        
        windowLevel = UIWindow.Level.statusBar + 100
        rootViewController = UIStoryboard(name: "Overlay", bundle: nil).instantiateInitialViewController()!
    }
    
    // MARK: - Hit testing
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if let viewController = rootViewController as? OverlayViewController {
            return viewController.recorderButton.frame.contains(point)
                || viewController.playerButton.frame.contains(point)
        }
        
        return false
    }

}
