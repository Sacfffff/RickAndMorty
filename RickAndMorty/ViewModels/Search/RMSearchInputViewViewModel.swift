//
//  RMSearchInputViewViewModel.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 30.01.23.
//

import Foundation

final class RMSearchInputViewViewModel {
    
    private let type : RMSearchViewController.Config.ConfigType
    
    init(type: RMSearchViewController.Config.ConfigType) {
        self.type = type
        
    }
    
    var hasDynamicOptions : Bool {
        
        let result : Bool
        
        switch type {
            
        case .episode:
            result = false
        default:
            result = true
        }
        
        return result
    }
    
    
    var options : [DynamicOptions] {
        
        let options : [DynamicOptions]
        
        switch type {
            
        case .episode:
            options = []
        case .characters:
            options = [.status, .gender]
        case .location:
            options = [.locationType]
        }
        
        return options
        
    }
    
    var searchPlaceholderText : String {
        
        let text : String
        
        switch type {
            
        case .episode:
            text = "Episode Title"
        case .characters:
            text = "Characters Name"
        case .location:
            text = "Location Name"
        }
        
        return text
        
    }
    
    
    
}

extension RMSearchInputViewViewModel {
    
    enum DynamicOptions : String {
        
        case status = "Status"
        case gender = "Gender"
        case locationType = "Location Type"
        
        var queryArgument : String {
            
            let queryArgument : String
            
            switch self {
                
            case .status:
                queryArgument = "status"
            case .gender:
                queryArgument = "gender"
            case .locationType:
                queryArgument = "type"
            }
            
            return queryArgument
        }
        
        var choices : [String] {
            
            let choices : [String]
            
            switch self {
                
            case .status:
                choices = ["alive", "dead", "unknown"]
            case .gender:
                choices = ["male", "female", "genderless", "uknown"]
            case .locationType:
                choices = ["planet", "cluster", "microverse"]
            }
            
            
            return choices
            
        }
        
    }
    
}
