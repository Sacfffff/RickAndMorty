//
//  RMCharacterInfoCellViewModel.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 7.01.23.
//

import UIKit

protocol RMCharacterInfoCellViewModelProtocol {
    
    var title : String {get}
    var displayValue : String {get}
    var iconImage : UIImage? {get}
    var tintColor : UIColor {get}
}

final class RMCharacterInfoCellViewModel : RMCharacterInfoCellViewModelProtocol {
    
    var iconImage: UIImage? {
        type.iconImage
    }
    
    var title: String {
        type.displayTitle
    }
    
    var tintColor : UIColor {
        type.tintColor
    }
    
    var displayValue : String {
        
        var displayValue = value
        
        if value.isEmpty {displayValue = "None"}
        
        if type == .created, let date = RMDateFormatter.shared.dateFormatter.date(from: value) {
            displayValue = RMDateFormatter.shared.shortDateFormatter.string(from: date)
        }
       
        return displayValue
    }
    
    private let type : TitleType
    private var value: String
    
    init(value: String, type: TitleType) {
        self.value = value
        self.type = type
    }
}
