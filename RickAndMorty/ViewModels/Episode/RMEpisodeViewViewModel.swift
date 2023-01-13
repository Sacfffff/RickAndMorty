//
//  RMEpisodeViewViewModel.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 13.01.23.
//

import UIKit

protocol RMEpisodeViewViewModelProtocol {
    
}

class RMEpisodeViewViewModel : RMEpisodeViewViewModelProtocol {

    private let endpointUrl : URL?
    
    init(url: URL?) {
        self.endpointUrl = url
        
        getEpisodeData()
    }
    
    private func getEpisodeData() {
        guard let url = endpointUrl, let request = RMRequest(url: url) else { return }
        
        RMService.shared.execute(request, expecting: RMEpisode.self) { result in
            switch result {
            case .success(let success):
                break
            case .failure(let failure):
                break
            }
        }
    }
    
}
