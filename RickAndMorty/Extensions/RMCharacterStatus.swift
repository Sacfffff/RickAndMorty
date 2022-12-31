//
//  Status.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 25.12.22.
//

import Foundation

enum RMCharacterStatus : String, Codable {
    
    case alive = "Alive"
    case dead = "Dead"
    case `unknown`
    
    var text : String {
        let text : String
        
        switch self {
            
        case .alive, .dead:
            text = rawValue
        case .unknown:
            text = "Unknown"
        }
        
        return text
    }
}

