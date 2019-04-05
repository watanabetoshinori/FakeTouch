//
//  TouchEvent.swift
//  FakeTouch
//
//  Created by Watanabe Toshinori on 2/7/19.
//  Copyright © 2019 Watanabe Toshinori. All rights reserved.
//

import UIKit

public struct TouchEvent: Codable {
    
    public let touches: [Touch]
    
    public let windowLevel: CGFloat
    
    public let timeInterval: TimeInterval
    
}

extension TouchEvent: CustomStringConvertible {

    public var description: String {
        let touchesDescription = touches.reduce(into: [String](), { $0.append($1.description) }).joined(separator: ",")
        return "{ timeInterval: \(timeInterval), windowLevel: \(windowLevel), touches: [\(touchesDescription)]}"
    }

}
