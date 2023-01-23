//
//  RMSettingsCellViewModel.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 21.01.23.
//

import UIKit

struct RMSettingsCellViewModel : Identifiable {
    
    let id  = UUID()
    
    var image : UIImage? {
        return type.iconImage
    }
    
    var title : String{
        type.displayTitle
    }
    
    var iconContainerColor : UIColor {
        type.iconContainerColor
    }
    
    var onTapHandler : (RMSettingsOption) -> Void
    let type : RMSettingsOption
    
    init(type: RMSettingsOption, onTapHandler: @escaping (RMSettingsOption) -> Void) {
        
        self.type = type
        self.onTapHandler = onTapHandler
    }
    
}
