//
//  RMSettingsCellViewModel.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 21.01.23.
//

import UIKit

struct RMSettingsCellViewModel : Identifiable, Hashable {
    
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
    
    private let type : RMSettingsOption
    
    init(type: RMSettingsOption) {
        
        self.type = type
    }
    
}
