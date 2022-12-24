//
//  TabBarViewControllers.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 24.12.22.
//

import UIKit

enum TabBarViewControllers : CaseIterable {
    case character
    case location
    case episode
    case settings
    
    var image : UIImage? {
        let image : UIImage?
        
        switch self {
        case .character:
            image = UIImage(named: "")
        case .location:
            image = UIImage(named: "")
        case .episode:
            image = UIImage(named: "")
        case .settings:
            image = UIImage(named: "")
        }
        
        return image
    }
    
    var title : String {
        let title : String
        switch self {
        case .character:
            title = "Characters"
        case .location:
            title = "Locations"
        case .episode:
            title = "Episodes"
        case .settings:
            title =  "Settings"
        }
        
        return title
    }
}
