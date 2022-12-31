//
//  RMCharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 31.12.22.
//

import Foundation


protocol RMCharacterDetailViewModelProtocol {
    
    var title : String {get}
}

final class RMCharacterDetailViewModel : RMCharacterDetailViewModelProtocol {
    
    var title : String {
        character.name.uppercased()
    }
    
    private let character : RMCharacter
    
    init(character: RMCharacter) {
        self.character = character
    }
    
    
}
