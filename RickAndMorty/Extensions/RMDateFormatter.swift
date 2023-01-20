//
//  RMDateFormatter.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 20.01.23.
//

import Foundation

final class RMDateFormatter {
    
    static let shared = RMDateFormatter()
    
    private init() {}
    
    let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSSSZ"
        formatter.timeZone = .current
        return formatter
    }()
    
    let shortDateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.timeStyle = .short
        formatter.dateStyle = .medium
        return formatter
    }()
    
}
