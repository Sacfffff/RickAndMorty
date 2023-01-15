//
//  RMCharacterEpisodeCellViewModel.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 7.01.23.
//

import Foundation

typealias EpisodeDataRendering = (name: String, airDate: String, episode: String)

protocol RMCharacterEpisodeCellViewModelProtocol {
    
    var update : ((EpisodeDataRendering)->Void)? {get set}
    
    func getEpisode()
}

final class RMCharacterEpisodeCellViewModel : RMCharacterEpisodeCellViewModelProtocol {
    
    var update: ((EpisodeDataRendering) -> Void)?
    
    private let episodeDataURL : URL?
    private var episode : RMEpisode? {
        didSet {
            guard let model = episode else { return }
            let renderingEpisode = (model.name, model.airDate, model.episode)
            update?(renderingEpisode)
            
        }
    }
    
    private var isFetching : Bool = false
    
    init(episodeDataURL: URL?) {
        self.episodeDataURL = episodeDataURL
    }
    
    func getEpisode() {
        guard !isFetching, let url = episodeDataURL, let request = RMRequest(url: url) else {
            
            if let model = episode {
                update?((model.name, model.airDate, model.episode))
            }
            
            return
        }
        
        isFetching = true
        
        RMService.shared.execute(request, expecting: RMEpisode.self) { [weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.episode = model
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}

extension RMCharacterEpisodeCellViewModel : Hashable, Equatable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(episodeDataURL?.absoluteString ?? "")
    }
    
    static func == (lhs: RMCharacterEpisodeCellViewModel, rhs: RMCharacterEpisodeCellViewModel) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    
}
