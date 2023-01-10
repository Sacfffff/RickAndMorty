//
//  RMCharacterPhotoCellViewModel.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 7.01.23.
//

import Foundation

protocol RMCharacterPhotoCellViewModelProtocol {
    
    func getImage(completion: @escaping (Result<Data, Error>) -> Void)
    
}

final class RMCharacterPhotoCellViewModel : RMCharacterPhotoCellViewModelProtocol {
    
    private let imageURL : URL?
    
    init(imageURL: URL?) {
        self.imageURL = imageURL
    }
    
    func getImage(completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = imageURL else {
            return completion(.failure(URLError(.badURL)))
            
        }
        
        RMImageLoaderManager.shared.downloadImage(with: url, completion: completion)
    }

}
