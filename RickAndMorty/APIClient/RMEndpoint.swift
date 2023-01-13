//
//  RMEndpoint.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 24.12.22.
//

import Foundation

/// Represents unique API endpoint
@frozen enum RMEndpoint : String, Hashable, CaseIterable {
    
    ///  Endpoint to get character info
    case character
    
    ///  Endpoint to get location info
    case location
    
    ///  Endpoint to get episode info
    case episode
}
