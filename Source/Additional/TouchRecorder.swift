//
//  TouchRecorder.swift
//  TouchTest2
//
//  Created by Watanabe Toshinori on 2/6/19.
//  Copyright © 2019 Watanabe Toshinori. All rights reserved.
//

import UIKit

public class TouchRecorder: NSObject {
    
    private enum State {
        case stopped
        case recording
        case paused
    }
    
    public typealias RecorderFinishHandler = ((_ touchs: [TouchEvent], _ error: Error?) -> Void)
    
    public var isRecording: Bool {
        switch state {
        case .recording, .paused:
            return true
        case .stopped:
            return false
        }
    }
    
    public var excludeWindow = [UIWindow]()
    
    private var state: State = .stopped
    
    private var events = [TouchEvent]()
    
    private var startedDate = Date()
    
    private var finishRecordingHandler: RecorderFinishHandler?
    
    // MARK: - Initializing a Singleton
    
    static public let shared = TouchRecorder()
    
    override private init() {
        
    }
    
    // MARK: - Controlling Recorder
    
    public func record(finishRecordingHandler: RecorderFinishHandler?) {
        if isRecording {
            return
        }
        
        self.finishRecordingHandler = finishRecordingHandler
        
        events.removeAll()
        
        startedDate = Date()
        
        UIWindow.swizzlingSendEvent()
        
        state = .recording
    }
    
    public func stop() {
        if isRecording == false {
            return
        }
        
        UIWindow.swizzlingSendEvent()
        
        state = .stopped
        
        if let finishRecordingHandler = finishRecordingHandler {
            DispatchQueue.main.async {
                finishRecordingHandler(self.events, nil)
            }
        }
    }
    
    public func pause() {
        state = .paused
    }
    
    public func resume() {
        startedDate = Date()
        
        state = .recording
    }
    
    // MARK: - Adding Touch Event
    
    fileprivate func add(_ uiEvent: UIEvent, in window: UIWindow) {
        guard state == .recording else {
            return
        }
        
        if excludeWindow.firstIndex(of: window) != nil {
            return
        }
        
        guard let uiTouches = uiEvent.allTouches, uiTouches.isEmpty == false else {
            return
        }
        
        let windowLevel = window.windowLevel.rawValue
        let timeInterval = Date().timeIntervalSince(startedDate)
        
        let touches = uiTouches.map { (uiTouch) -> Touch in
            return Touch(id: uiTouch.id,
                         location: uiTouch.location(in: window),
                         previousLocation: uiTouch.previousLocation(in: window),
                         phase: uiTouch.phase)
        }
        
        let event = TouchEvent(
            touches: touches,
            windowLevel: windowLevel,
            timeInterval: timeInterval
        )
        
        DispatchQueue.main.async {
            self.events.append(event)
        }
    }
    
}

// MARK: - UIWindow extesnion for recording Touch event

extension UIWindow {
    
    @objc func swizzledSendEvent(_ event: UIEvent) {
        TouchRecorder.shared.add(event, in: self)
        
        swizzledSendEvent(event)
    }
    
    fileprivate class func swizzlingSendEvent() {
        let origin = #selector(UIWindow.sendEvent(_:))
        let swizzled = #selector(UIWindow.swizzledSendEvent(_:))
        
        let `class` = object_getClass(UIWindow(frame: .zero))
        
        guard let originalMethod = class_getInstanceMethod(`class`, origin),
            let swizzledMethod = class_getInstanceMethod(`class`, swizzled) else {
                fatalError("Failed to get instance method.")
        }
        
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
    
}
