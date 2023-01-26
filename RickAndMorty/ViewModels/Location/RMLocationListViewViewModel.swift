//
//  RMLocationListViewViewModel.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 26.01.23.
//

import Foundation

protocol RMLocationListViewViewModelProtocol {
    
    
}

final class RMLocationListViewViewModel : RMLocationListViewViewModelProtocol {
    
    private var locations : [RMLocation] = []
    private var cellViewModels : [String] = []
    
    private var hasMoreResults : Bool {
        return false
    }
    
    init() {
        
    }
    
    func getLocations() {
        
        RMService.shared.execute(.listOfLocationsRequest, expecting: String.self) { result in
            switch result {
            case .success(let success):
                break
            case .failure(let failure):
                break
            }
        }
    }
    
}
