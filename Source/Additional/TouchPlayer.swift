//
//  TouchPlayer.swift
//  TouchTest2
//
//  Created by Watanabe Toshinori on 2/6/19.
//  Copyright © 2019 Watanabe Toshinori. All rights reserved.
//

import UIKit

public class TouchPlayer: NSObject {
    
    private enum State {
        case stopped
        case playing
    }
    
    public typealias PlayerFinishHandler = ((_ error: Error?) -> Void)
    
    public var isPlaying: Bool {
        return state == .playing
    }
    
    private var state: State = .stopped
    
    private var events: [TouchEvent]!
    
    private var touchObjects = [String: UITouch]()
    
    private var finishPlayHandler: PlayerFinishHandler?
    
    // MARK: - Initializing Player
    
    convenience public init(events: [TouchEvent]) {
        self.init()
        self.events = events
    }
    
    // MARK: - Controlling
    
    public func play(finishPlayHandler: PlayerFinishHandler?) {
        if isPlaying {
            return
        }
        
        self.finishPlayHandler = finishPlayHandler
        
        state = .playing
        
        let group = DispatchGroup()
        
        events.forEach { event in
            group.enter()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + event.timeInterval) {
                defer {
                    group.leave()
                }
                
                if self.state != .playing {
                    return
                }
                
                let touchObjects = event.touches.map({ (touch) -> UITouch in
                    return self.touchObject(for: touch, windowLevel: event.windowLevel)
                })
                
                UIEvent.send(touches: touchObjects)
            }
        }
        
        group.notify(queue: .main) {
            self.stop()
        }
    }
    
    public func stop() {
        if isPlaying == false {
            return
        }
        
        state = .stopped
        
        if let finishPlayHandler = finishPlayHandler {
            finishPlayHandler(nil)
        }
    }
    
    // MARK: - Getting UITouch
    
    private func touchObject(for touch: Touch, windowLevel: CGFloat) -> UITouch {
        if let touchObject = touchObjects[touch.id] {
            // Reusing previous UITouch
            
            touchObject.setLocation(touch.location)
            touchObject.setPreviousLocation(touch.previousLocation)
            touchObject.setPhase(touch.phase)
            touchObject.udpateTimestamp()
            
            if touch.phase == .ended {
                touchObjects[touch.id] = nil
            }
            
            return touchObject
            
        } else {
            // Creating new UITouch
            
            let window = UIApplication.shared.windows.first(where: { $0.windowLevel.rawValue == windowLevel }) ?? UIApplication.shared.keyWindow!
            
            let touchObject = UITouch(with: touch.location, previousLocation: touch.previousLocation, in: window)
            touchObjects[touch.id] = touchObject
            return touchObject
        }
    }
    
}
