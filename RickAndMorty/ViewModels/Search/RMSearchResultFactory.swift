//
//  RMSearchResultFactory.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 26.02.23.
//

import Foundation

class RMSearchResultFactory {
    
    private let model : any RMGetAllResponceType
    
    
    init(model: any RMGetAllResponceType) {
        self.model = model
    }
    
    
    func getViewModel() -> RMSearchResultType? {
        
        var resultsVM : RMSearchResultType?
        
        if let characters = model as? RMGetAllCharactersResponce {
            resultsVM = .characters(characters.results.compactMap({ RMCharactersCollectionViewCellViewModel(characterName: $0.name, characterStatus: $0.status, characterImageURL: URL(string: $0.image)) }))
        } else if let locations = model as? RMGetAllLocationsResponce{
            resultsVM = .locations(locations.results.compactMap({ RMLocationTableViewCellViewModel(location: $0) }))
        } else if let episodes = model as? RMGetAllEpisodesResponce {
            resultsVM = .episodes(episodes.results.compactMap({ RMCharacterEpisodeCellViewModel(episodeDataURL: URL(string: $0.url)) }))
        }
        
       return resultsVM
        
    }
    
}

enum RMSearchResultType {
    
    case characters([RMCharactersCollectionViewCellViewModel])
    case locations([RMLocationTableViewCellViewModel])
    case episodes([RMCharacterEpisodeCellViewModel])
    
}
