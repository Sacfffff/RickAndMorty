//
//  RMService.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 24.12.22.
//

import Foundation


/// Primary API service object to get Rick and Morty data
final class RMService {
    
    /// Shared singleton instance
    static let shared = RMService()
    
    ///Privatized constructor
    private init () {}
    
    
    /// Send rick and Morty API Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - completion: Callback data or error
    public func execute(_ request: RMRequest, completion: @escaping () -> Void) {
        
    }
}
