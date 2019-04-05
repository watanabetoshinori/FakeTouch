//
//  UIEvent+FakeTouch.swift
//  FakeTouch
//
//  Created by Watanabe Toshinori on 2/7/19.
//  Copyright © 2019 Watanabe Toshinori. All rights reserved.
//

import UIKit

extension UIEvent {
    
    public class func send(touches: [UITouch]) {
        guard let event = UIApplication.shared._touchesEvent() else {
            return
        }
        
        event._clearTouches()

        touches.forEach { (touch) in
            event._add(touch, forDelayedDelivery: false)
        }

        UIApplication.shared.sendEvent(event)
        
        touches.forEach { (touch) in
            if touch.phase == .began || touch.phase == .moved {
                touch.setPhase(.stationary)
                touch.udpateTimestamp()
            }
        }
    }
    
}
