//
//  Touch.swift
//  TouchTest2
//
//  Created by Watanabe Toshinori on 2/6/19.
//  Copyright © 2019 Watanabe Toshinori. All rights reserved.
//

import UIKit

public struct Touch: Codable {
    
    public var id: String
    
    public var location: CGPoint
    
    public var previousLocation: CGPoint
    
    public var phase: UITouch.Phase
    
    enum CodingKeys: String, CodingKey {
        case id
        case location
        case phase
        case previousLocation
        
    }
    
    public init(id: String, location: CGPoint, previousLocation: CGPoint, phase: UITouch.Phase) {
        self.id = id
        self.location = location
        self.phase = phase
        self.previousLocation = previousLocation
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        location = try values.decode(CGPoint.self, forKey: .location)
        previousLocation = try values.decode(CGPoint.self, forKey: .previousLocation)
        let phaseValue = try values.decode(String.self, forKey: .phase)
        phase = UITouch.Phase(value: phaseValue)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(location, forKey: .location)
        try container.encode(previousLocation, forKey: .previousLocation)
        try container.encode(phase.value, forKey: .phase)
    }
    
}

extension Touch: CustomStringConvertible {
    
    public var description: String {
        return "{ id: \(id), location: \(location), phase: \(phase.value)}"
    }
}

extension UITouch.Phase {
    
    init(value: String) {
        switch value {
        case "began":
            self = .began
        case "moved":
            self = .moved
        case "ended":
            self = .ended
        case "cancelled":
            self = .cancelled
        default:
            self = .stationary
        }
    }
    
    var value: String {
        switch self {
        case .began:
            return "began"
        case .moved:
            return "moved"
        case .ended:
            return "ended"
        case .cancelled:
            return "cancelled"
        case .stationary:
            return "stationary"
        }
    }
    
}
