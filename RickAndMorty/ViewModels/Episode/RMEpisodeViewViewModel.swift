//
//  RMEpisodeViewViewModel.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 13.01.23.
//

import UIKit

protocol RMEpisodeViewViewModelProtocol {
    
    var update : (() -> Void)? {get set}
    var cellViewModels : [RMEpisodeDetailView.SectionType] {get}
    
    func getEpisodeData() 
    
}

final class RMEpisodeViewViewModel : RMEpisodeViewViewModelProtocol {
    
    private(set) var cellViewModels : [RMEpisodeDetailView.SectionType] = []
    var update: (() -> Void)?
    
    private let endpointUrl : URL?
    private var dataTuple: (episode: RMEpisode, characters: [RMCharacter])? {
        didSet {
            createCellViewModels()
            update?()
        }
    }
    
    init(url: URL?) {
        self.endpointUrl = url
        
    }
    
    /// Fetch backing episode model
     func getEpisodeData() {
        guard let url = endpointUrl, let request = RMRequest(url: url) else { return }
        
        RMService.shared.execute(request, expecting: RMEpisode.self) { [weak self] result in
            switch result {
            case .success(let episode):
                self?.fetchRelatedCharacters(episode: episode)
            case .failure(let failure):
                break
            }
        }
    }
    
    private func createCellViewModels() {
        
        guard let episode = dataTuple?.episode, let characters = dataTuple?.characters else { return }
        
        cellViewModels =
        [
            .information(viewModels:
                            [
                                .init(title: "Episode name", value: episode.name),
                                .init(title: "Air date", value: episode.airDate),
                                .init(title: "Episode", value: episode.episode),
                                .init(title: "Created", value: episode.created),
                            ]
                        ),
            .characters(viewModels: characters.compactMap{ RMCharactersCollectionViewCellViewModel(characterName: $0.name, characterStatus: $0.status, characterImageURL: URL(string: $0.image))})
        ]
    }
    
    private func fetchRelatedCharacters(episode: RMEpisode) {
        let requests : [RMRequest] = episode.characters.compactMap{ URL(string: $0) }.compactMap{ RMRequest(url: $0) }
        
        let group = DispatchGroup()
        
        var characters : [RMCharacter] = []
        
        requests.forEach {
            group.enter()
            RMService.shared.execute($0, expecting: RMCharacter.self) { result in
                defer {
                    group.leave()
                }
                switch result {
                case .success(let model):
                    characters.append(model)
                case .failure:
                    break
                }
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.dataTuple = (episode: episode, characters: characters)
        }
    }
}
