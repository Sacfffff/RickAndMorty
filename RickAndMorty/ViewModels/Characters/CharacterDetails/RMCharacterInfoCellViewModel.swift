//
//  RMCharacterInfoCellViewModel.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 7.01.23.
//

import Foundation

protocol RMCharacterInfoCellViewModelProtocol {
    
}

final class RMCharacterInfoCellViewModel : RMCharacterInfoCellViewModelProtocol {
    
    private let value : String
    private let title : String
    
    init(value: String, title: String) {
        self.value = value
        self.title = title
    }
    
}
