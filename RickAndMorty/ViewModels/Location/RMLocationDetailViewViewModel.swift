//
//  RMLocationDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 29.01.23.
//

import Foundation

protocol RMLocationDetailViewViewModelProtocol {
    
    var update : (() -> Void)? {get set}
    var cellViewModels : [RMLocationDetailView.SectionType] {get}
    
    func getLocationData()
    func character(at index: Int) -> RMCharacter?
    
}

final class RMLocationDetailViewViewModel : RMLocationDetailViewViewModelProtocol {
    
    private(set) var cellViewModels : [RMLocationDetailView.SectionType] = []
    var update: (() -> Void)?
    
    private let endpointUrl : URL?
    private var dataTuple: (location: RMLocation, characters: [RMCharacter])? {
        didSet {
            createCellViewModels()
            update?()
        }
    }
    
    init(url: URL?) {
        self.endpointUrl = url
        
    }
    
    func character(at index: Int) -> RMCharacter?  {
        
        guard let dataTuple = dataTuple else { return nil }
        
        return dataTuple.characters[index]
        
    }
    
    /// Fetch backing location model
     func getLocationData() {
        guard let url = endpointUrl, let request = RMRequest(url: url) else { return }
        
        RMService.shared.execute(request, expecting: RMLocation.self) { [weak self] result in
            switch result {
            case .success(let location):
                self?.fetchRelatedCharacters(location: location)
            case .failure(let failure):
                break
            }
        }
    }
    
    private func createCellViewModels() {
        
        guard let location = dataTuple?.location, let characters = dataTuple?.characters else { return }
        
        var createdString : String = location.created
        
        if let createdDate = RMDateFormatter.shared.dateFormatter.date(from: location.created) {
            createdString = RMDateFormatter.shared.shortDateFormatter.string(from: createdDate)
        }
       
        cellViewModels =
        [
            .information(viewModels:
                            [
                                .init(title: "Location name", value: location.name),
                                .init(title: "Type", value: location.type),
                                .init(title: "Dimension", value: location.dimension),
                                .init(title: "Created", value: createdString),
                            ]
                        ),
            .characters(viewModels: characters.compactMap{ RMCharactersCollectionViewCellViewModel(characterName: $0.name, characterStatus: $0.status, characterImageURL: URL(string: $0.image))})
        ]
    }
    
    private func fetchRelatedCharacters(location: RMLocation) {
        let requests : [RMRequest] = location.residents.compactMap{ URL(string: $0) }.compactMap{ RMRequest(url: $0) }
        
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
            self?.dataTuple = (location: location, characters: characters)
        }
    }
}
