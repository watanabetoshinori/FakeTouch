//
//  UITouch+Simulate.swift
//  FakeTouch
//
//  Created by Watanabe Toshinori on 2/6/19.
//  Copyright © 2019 Watanabe Toshinori. All rights reserved.
//

import UIKit

extension UITouch {
    
    public var id: String {
        return String(format: "%p", unsafeBitCast(self, to: Int.self))
    }
    
    // MARK: - Initialize UITouch
    
    convenience public init(with location: CGPoint, in window: UIWindow) {
        self.init()
        
        let view = window.hitTest(location, with: nil)
        
        setWindow(window)
        setView(view)
        setTapCount(1)
        setPhase(.began)
        _setIsFirstTouch(forView: true)
        setIsTap(true)
        
        _setLocation(inWindow: location, resetPrevious: true)
        setTimestamp(ProcessInfo.processInfo.systemUptime)

        if responds(to: #selector(setGestureView(_:))) {
            setGestureView(view)
        }
        
        let event = kif_IOHIDEventWithTouches([self])
        _setHidEvent(event)
    }
    
    // MARK: - Updating values
    
    public func setLocation(_ location: CGPoint) {
        _setLocation(inWindow: location, resetPrevious: true)
    }
    
    public func udpateTimestamp() {
        setTimestamp(ProcessInfo.processInfo.systemUptime)
    }
    
}
