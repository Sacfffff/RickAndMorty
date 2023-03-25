//
//  RMSearchResultsViewModel.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 25.03.23.
//

import Foundation

enum RMSearchResultType {
    
    case characters([RMCharactersCollectionViewCellViewModel])
    case locations([RMLocationTableViewCellViewModel])
    case episodes([RMCharacterEpisodeCellViewModel])
    
}

final class RMSearchResultViewModel {
    
    private(set) var result : RMSearchResultType
    private var next : String?
    
    private var isLoadingMoreResults : Bool = false
    var hasMoreResults : Bool {
        next != nil && !isLoadingMoreResults
    }
    
    init(result: RMSearchResultType, next: String?) {
        
        self.result = result
        self.next = next
        
    }
    
    
    func getAdditionalLocations(completion: @escaping (([RMLocationTableViewCellViewModel]) -> Void)) {
        
        guard !isLoadingMoreResults, let nextUrlString = next, let url = URL(string: nextUrlString) else { return }
        
        isLoadingMoreResults = true
        
        guard let request = RMRequest(url: url) else {
            isLoadingMoreResults = false
            return
        }
        
        RMService.shared.execute(request, expecting: RMGetAllLocationsResponce.self) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                
            case .success(let model):
                let moreResults = model.results.compactMap { RMLocationTableViewCellViewModel(location: $0)}
                self.next = model.info.next
                var newResults : [RMLocationTableViewCellViewModel] = []
                switch self.result {
                case .locations(let existingResults):
                    newResults = existingResults + moreResults
                    self.result = .locations(newResults)
                    break
                default:break
                    
                }
                
                DispatchQueue.main.async {
                    completion(newResults)
                    self.isLoadingMoreResults = false
                }
            case .failure(_):
                self.isLoadingMoreResults = false
            }
        }
        
    }
    
}
