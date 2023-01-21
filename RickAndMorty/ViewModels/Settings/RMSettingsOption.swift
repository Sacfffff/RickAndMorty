//
//  RMSettingsOption.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 21.01.23.
//

import UIKit

enum RMSettingsOption : CaseIterable {
    
    case rateApp
    case contactUs
    case terms
    case privacy
    case apiReference
    case viewSeries
    case viewCode
    
    var displayTitle: String {
        
        var displayTitle : String
        
        switch self {
            
        case .rateApp:
            displayTitle = "Rate App"
        case .contactUs:
            displayTitle = "Contact Us"
        case .terms:
            displayTitle = "Terms of Service"
        case .privacy:
            displayTitle = "Privacy Policy"
        case .apiReference:
            displayTitle = "API Refernce"
        case .viewSeries:
            displayTitle = "View Video Series"
        case .viewCode:
            displayTitle = "View App Code"
        }
        
        
        return displayTitle
        
    }
    
    var iconContainerColor : UIColor {
        
        let color : UIColor
        
        switch self {
            
        case .rateApp:
            color = .systemBlue
        case .contactUs:
            color = .systemRed
        case .terms:
            color = .systemGreen
        case .privacy:
            color = .systemYellow
        case .apiReference:
            color = .systemOrange
        case .viewSeries:
            color = .systemPink
        case .viewCode:
            color = .systemPurple
        }
        
        return color
        
    }
    
    var iconImage : UIImage? {
        
        var image : UIImage?
        
        switch self {
            
        case .rateApp:
            image = UIImage(systemName: "star.fill")
        case .contactUs:
            image = UIImage(systemName: "paperplane")
        case .terms:
            image = UIImage(systemName: "doc")
        case .privacy:
            image = UIImage(systemName: "lock")
        case .apiReference:
            image = UIImage(systemName: "list.clipboard")
        case .viewSeries:
            image = UIImage(systemName: "tv.fill")
        case .viewCode:
            image = UIImage(systemName: "hammer.fill")
        }
        
        
        return image
        
        
    }
    
}
