//
//  RMCharacterEpisodeCellViewModel.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 7.01.23.
//

import Foundation


protocol RMCharacterEpisodeCellViewModelProtocol {
    
}

final class RMCharacterEpisodeCellViewModel : RMCharacterEpisodeCellViewModelProtocol {
 
   private let episodeDataURL : URL?
    
    init(episodeDataURL: URL?) {
        self.episodeDataURL = episodeDataURL
    }
}
