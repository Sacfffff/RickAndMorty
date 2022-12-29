//
//  RMCharactersCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 29.12.22.
//

import Foundation

final class RMCharactersCollectionViewCellViewModel {
    
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
        characterStatus.rawValue
    }
    
    func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = characterImageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else  {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            
            completion(.success(data))
        }.resume()
    }
}
