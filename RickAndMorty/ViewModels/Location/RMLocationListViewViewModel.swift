//
//  RMLocationListViewViewModel.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 26.01.23.
//

import Foundation

protocol RMLocationListViewViewModelProtocol {
    
    var delegate : RMLocationListViewViewModelDelegate? {get set}
    var cellViewModels : [RMLocationTableViewCellViewModel]{get}
      
    func getLocations()
    func location(at index: Int) -> RMLocation?
    
}

protocol RMLocationListViewViewModelDelegate : AnyObject {
    
    func rmDidGetLocations()
}

final class RMLocationListViewViewModel : RMLocationListViewViewModelProtocol {
    
    weak var delegate : RMLocationListViewViewModelDelegate?
    
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
    
    func location(at index: Int) -> RMLocation? {
        
        guard !(index >= locations.count) else { return nil}
        
        return self.locations[index]
        
    }
    
    func getLocations() {
        
        RMService.shared.execute(.listOfLocationsRequest, expecting: RMGetAllLocationsResponce.self) { [weak self] result in
            
            switch result {
            case .success(let model):
                self?.apiInfo = model.info
                self?.locations = model.results
               
                DispatchQueue.main.async {
                    self?.delegate?.rmDidGetLocations()
                }
                
            case .failure(_):
                break
            }
        }
    }
    
}
