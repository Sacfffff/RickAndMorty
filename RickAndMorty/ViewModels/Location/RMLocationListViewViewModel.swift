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
    var hasMoreResults : Bool {get}
    
    func getLocations()
    func getAdditionalLocations()
    func location(at index: Int) -> RMLocation?
    func registerPaginationDidFinishBlock(_ block: @escaping (()->Void))
    
}

protocol RMLocationListViewViewModelDelegate : AnyObject {
    
    func rmDidGetLocations()
}

final class RMLocationListViewViewModel : RMLocationListViewViewModelProtocol {
    
    weak var delegate : RMLocationListViewViewModelDelegate?
    
    var cellViewModels : [RMLocationTableViewCellViewModel] = []
    
    var hasMoreResults : Bool {
        return apiInfo?.next != nil && !isLoadingMoreLocations
    }
    
    private var didFinishPagination : (()->Void)?
    
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
    
    private var isLoadingMoreLocations : Bool = false
    
    func location(at index: Int) -> RMLocation? {
        
        guard !(index >= locations.count) else { return nil}
        
        return self.locations[index]
        
    }
    
    
    func registerPaginationDidFinishBlock(_ block: @escaping (()->Void)) {
        
        self.didFinishPagination = block
        
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
    
    
    /// Paginate if additional locations are needed
    func getAdditionalLocations() {
        
        guard !isLoadingMoreLocations, let nextUrlString = apiInfo?.next, let url = URL(string: nextUrlString) else { return }
        
        isLoadingMoreLocations = true
        
        guard let request = RMRequest(url: url) else {
            isLoadingMoreLocations = false
            return
        }
        
        RMService.shared.execute(request, expecting: RMGetAllLocationsResponce.self) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                
            case .success(let model):
                let moreResults = model.results
                self.apiInfo = model.info
                self.locations.append(contentsOf: moreResults)
                
                DispatchQueue.main.async {
                    self.didFinishPagination?()
                    self.isLoadingMoreLocations = false
                }
            case .failure(_):
                self.isLoadingMoreLocations = false
            }
        }
        
    }
    
}
