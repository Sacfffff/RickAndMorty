//
//  RMCharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 31.12.22.
//

import Foundation


enum SectionType  : CaseIterable {
    case photo
    case information
    case episodes
}

protocol RMCharacterDetailViewModelProtocol {
    
    var title : String {get}
    var sections : [SectionType] {get}
}

final class RMCharacterDetailViewModel : RMCharacterDetailViewModelProtocol {
    
    var sections : [SectionType] = SectionType.allCases
    
    var title : String {
        character.name.uppercased()
    }
    
    private var requestURL : URL? {
        URL(string: character.url)
    }
    
    private let character : RMCharacter
    
    init(character: RMCharacter) {
        self.character = character
    }
    
    
}
