//
//  RMLocationListViewViewModel.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 26.01.23.
//

import Foundation

protocol RMLocationListViewViewModelProtocol {
    
    var update : (() -> Void)?{get set}
    var cellViewModels : [RMLocationTableViewCellViewModel]{get}
    
    func getLocations()
    
}

final class RMLocationListViewViewModel : RMLocationListViewViewModelProtocol {
    
    var update: (() -> Void)?
    
    var cellViewModels : [RMLocationTableViewCellViewModel] = []
    
    private var locations : [RMLocation] = [] {
        
        didSet {
            
            locations.forEach{
                
                let cellViewModel = RMLocationTableViewCellViewModel(location: $0)
                
                if !cellViewModels.contains(cellViewModel) {
                    cellViewModels.append(cellViewModel)
                }
            }
        }
        
    }
    
    private var apiInfo : RMGetAllLocationssResponceInfo?
    
    private var hasMoreResults : Bool {
        return false
    }
    
    init() {
        
    }
    
    func getLocations() {
        
        RMService.shared.execute(.listOfLocationsRequest, expecting: RMGetAllLocationsResponce.self) { [weak self] result in
            
            switch result {
            case .success(let model):
                self?.apiInfo = model.info
                self?.locations = model.results
               
                DispatchQueue.main.async {
                    self?.update?()
                }
                
            case .failure(let failure):
                break
            }
        }
    }
    
}
