//
//  RMCharacterInfoCellViewModel+TitleType.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 10.01.23.
//

import UIKit

extension  RMCharacterInfoCellViewModel {
    
    enum TitleType : String {
        
        case status
        case personType
        case gender
        case species
        case origin
        case created
        case location
        case episodeNumber
        
        var displayTitle : String {
            
            let title : String
            
            switch self {
                
            case .episodeNumber:
                title = "TOTAL EPISODES"
            case .personType:
                title = "TYPE"
            default:
                title = rawValue.uppercased()
            }
            
            return title
        }
        
        var iconImage: UIImage? {
            
            let imageName : String
            
            switch self {
                
            case .status:
                imageName = "person.circle"
            case .personType:
                imageName = "infinity.circle"
            case .species:
                imageName = "globe.europe.africa"
            case .origin:
                imageName = "location.north.line"
            case .gender:
                imageName = "person"
            case .created:
                imageName = "line.2.horizontal.decrease.circle"
            case .location:
                imageName = "location.circle"
            case .episodeNumber:
                imageName = "number.circle"
            }
            
            return UIImage(systemName: imageName)
        }
        
        
        var tintColor: UIColor {
            
            let color : UIColor
            
            switch self {
                
            case .status:
                color = .systemBlue
            case .personType:
                color = .systemPurple
            case .species:
                color = .systemPink
            case .origin:
                color = .systemCyan
            case .gender:
                color = .systemMint
            case .created:
                color = .systemTeal
            case .location:
                color = .systemYellow
            case .episodeNumber:
                color = .systemGreen
            }
            
            return color
        }
   }
}
