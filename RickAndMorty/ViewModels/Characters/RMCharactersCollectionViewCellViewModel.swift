//
//  RMCharactersCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 29.12.22.
//

import Foundation

final class RMCharactersCollectionViewCellViewModel : Hashable, Equatable {
    
    let characterName: String
    
    private let characterStatus: RMCharacterStatus
    private let characterImageURL: URL?
    
    //MARK: - Init
    
    init(characterName: String, characterStatus: RMCharacterStatus, characterImageURL: URL?) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageURL = characterImageURL
    }
    
    
    var characterStatusText : String {
        "Status: \(characterStatus.text)"
    }
    
    
    func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = characterImageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        RMImageLoaderManager.shared.downloadImage(with: url, completion: completion)
        
       
    }
    
    //MARK: - Hashable
    
    static func == (lhs: RMCharactersCollectionViewCellViewModel, rhs: RMCharactersCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageURL)
    }
}
